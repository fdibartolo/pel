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

      it "should be success" do
        patch :update, payload, session
        response.should be_success
      end

      it "should respond with created request id" do
        FactoryGirl.create :user, enterprise_id: 'user1'
        patch :update, payload, session
        body = JSON.parse response.body
        body['id'].should == @some_request.id
      end

      it "should respond with valid and invalid recipients" do
        FactoryGirl.create :user, enterprise_id: 'user1'
        patch :update, payload, session
        body = JSON.parse response.body
        body['valid_recipients'].count.should == 1
        body['valid_recipients'][0].should == 'user1'
        body['invalid_recipients'].count.should == 2
        body['invalid_recipients'][0].should == 'user2'
        body['invalid_recipients'][1].should == 'user3'
      end

      it "should respond with created message" do
        FactoryGirl.create :user, enterprise_id: 'user1'
        patch :update, payload, session
        body = JSON.parse response.body
        body['message'].should == payload['message']
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
end
