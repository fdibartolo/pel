require 'spec_helper'

describe Api::RequestsController do
  def valid_session
    user.roles << FactoryGirl.build(:role, name: RequestorRole)
    { enterprise_id: user.enterprise_id }
  end

  let(:user) { FactoryGirl.create :user }
  let(:payload) { {'recipients' => ['user1','user2','user3'], 'message' => 'Please complete a PEL!'} }

  context "creating a request" do
    context "with invalid params" do
      it "should return 401 if no current_user" do
        post :create, payload
        response.status.should == 401
      end

      it "should return 403 if current_user has no ability" do
        session = { enterprise_id: user.enterprise_id }
        post :create, payload, session
        response.status.should == 403
      end
    end

    context "with valid params" do
      it "should be success" do
        post :create, payload, valid_session
        response.should be_success
      end

      it "should create request to given owner" do
        post :create, payload, valid_session
        Request.last.owner_id.should == user.id
      end

      it "should respond with created request id" do
        FactoryGirl.create :user, enterprise_id: 'user1'
        post :create, payload, valid_session
        body = JSON.parse response.body
        body['id'].should == Request.last.id
      end

      it "should respond with valid and invalid recipients" do
        FactoryGirl.create :user, enterprise_id: 'user1'
        post :create, payload, valid_session
        body = JSON.parse response.body
        body['valid_recipients'].count.should == 1
        body['valid_recipients'][0].should == 'user1'
        body['invalid_recipients'].count.should == 2
        body['invalid_recipients'][0].should == 'user2'
        body['invalid_recipients'][1].should == 'user3'
      end

      it "should respond with created message" do
        FactoryGirl.create :user, enterprise_id: 'user1'
        post :create, payload, valid_session
        body = JSON.parse response.body
        body['message'].should == payload['message']
      end
    end
  end

  context "updating a request" do
    before :each do
      @requestor = FactoryGirl.create(:user, enterprise_id: 'requestor')
      @requestor.roles << FactoryGirl.create(:role, name: RequestorRole)
      @some_request = FactoryGirl.create(:request, owner: @requestor)
      payload['id'] = @some_request.id
    end

    context "with invalid params" do
      it "should return 401 if no current_user" do
        patch :update, payload
        response.status.should == 401
      end

      it "should return 403 if current_user has no ability" do
        session = { enterprise_id: user.enterprise_id }
        patch :update, payload, session
        response.status.should == 403
      end
    end

    context "with valid params" do
      let(:session) { { enterprise_id: @requestor.enterprise_id } }
      
      before :each do
        @user = FactoryGirl.create :user, enterprise_id: 'user1'
      end

      it "should be success" do
        patch :update, payload, session
        response.should be_success
      end

      it "should respond with created request id" do
        patch :update, payload, session
        body = JSON.parse response.body
        body['id'].should == @some_request.id
      end

      it "should respond with valid and invalid recipients" do
        patch :update, payload, session
        body = JSON.parse response.body
        body['valid_recipients'].count.should == 1
        body['valid_recipients'][0].should == 'user1'
        body['invalid_recipients'].count.should == 2
        body['invalid_recipients'][0].should == 'user2'
        body['invalid_recipients'][1].should == 'user3'
      end

      it "should respond with created message" do
        patch :update, payload, session
        body = JSON.parse response.body
        body['message'].should == payload['message']
      end

      it "should not add a recipient if it is already present" do
        @some_request.recipients << @user
        patch :update, payload, session
        body = JSON.parse response.body
        body['valid_recipients'].count.should == 1
        body['valid_recipients'][0].should == 'user1'
      end
    end
  end

  context "getting a new request" do
    context "with invalid params" do
      it "should return 401 if no current_user" do
        get :new
        response.status.should == 401
      end

      it "should return 403 if current_user has no ability" do
        session = { enterprise_id: user.enterprise_id }
        get :new, {}, session
        response.status.should == 403
      end
    end

    context "with valid params" do
      it "should be success" do
        get :new, {}, valid_session
        response.should be_success
      end

      it "should include empty list of recipients within the response" do
        get :new, {}, valid_session
        body = JSON.parse response.body
        body.should include 'recipients'
        body['recipients'].should be_an Array
        body['recipients'].should be_empty
      end

      it "should include empty message within the response" do
        get :new, {}, valid_session
        body = JSON.parse response.body
        body.should include 'message'
      end
    end
  end

  context "retrieving requests for current user" do
    context "with invalid params" do
      it "should return 401 if no current_user" do
        get :all_for_current_user
        response.status.should == 401
      end
    end

    context "with valid params" do
      before :each do
        requestor = FactoryGirl.create(:user, enterprise_id: 'requestor')
        @some_request = FactoryGirl.create(:request, owner: requestor)
        @some_request.add_recipients_and_return_invalid [user.enterprise_id]
        another_requestor = FactoryGirl.create(:user, enterprise_id: 'another_requestor')
        @another_request = FactoryGirl.create(:request, owner: another_requestor)
        @another_request.add_recipients_and_return_invalid [user.enterprise_id]

        # one more request NOT for the current user
        FactoryGirl.create(:request, owner: requestor)
      end

      it "should be success" do
        get :all_for_current_user, {}, valid_session
        response.should be_success
      end

      it "should include the two requests" do
        get :all_for_current_user, {}, valid_session
        body = JSON.parse response.body
        body.should be_an Array
        body.count.should == 2
        body.first['id'].should == @some_request.id
        body.first['owner'].should == @some_request.owner.enterprise_id
        body.last['id'].should == @another_request.id
        body.last['owner'].should == @another_request.owner.enterprise_id
      end

      it "should include related requisition" do
        pel = FactoryGirl.create :personal_engagement_list, user: user
        requisition = @some_request.requisition_for user
        requisition.personal_engagement_list_id = pel.id
        requisition.save!

        get :all_for_current_user, {}, valid_session
        body = JSON.parse response.body
        body.first['requisition_id'].should be_present
        body.first['requisition_pel_id'].should == pel.id
      end
    end
  end

  context "submiting a requisition" do
    before :each do
      requestor = FactoryGirl.create(:user, enterprise_id: 'requestor')
      @some_request = FactoryGirl.create(:request, owner: requestor)
      @pel = FactoryGirl.create :personal_engagement_list

      @some_request.recipients << user

      @payload = { format: :json, id: @some_request.id, personal_engagement_list_id: @pel.id }
    end

    context "with invalid params" do
      it "should return 401 if no current_user" do
        patch :submit_requisition, @payload
        response.status.should == 401
      end

      it "should include error if request does not exist" do
        invalid_id = @some_request.id + 1
        @payload[:id] = invalid_id
        patch :submit_requisition, @payload, valid_session
        body = JSON.parse response.body
        body['errors'].should include "Cannot find Request with id=#{invalid_id}"
      end

      it "should include error if pel id is not provided" do
        @payload.delete :personal_engagement_list_id
        expect{ patch :submit_requisition, @payload, valid_session }.to raise_error ActionController::ParameterMissing
      end

      it "should include error if pel does not exist" do
        invalid_id = @pel.id + 1
        @payload[:personal_engagement_list_id] = invalid_id
        patch :submit_requisition, @payload, valid_session
        body = JSON.parse response.body
        body['errors'].should include "Cannot find PEL with id=#{invalid_id}"
      end
    end

    context "with valid params" do
      it "should return saved requisition" do
        patch :submit_requisition, @payload, valid_session
        body = JSON.parse response.body
        body['requisition_id'].should be_present
      end
    end
  end
end
