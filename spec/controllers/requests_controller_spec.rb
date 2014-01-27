require 'spec_helper'

describe Api::RequestsController do
  def valid_session
    user.roles << FactoryGirl.build(:role, name: RequestorRole)
    { enterprise_id: user.enterprise_id }
  end

  let(:user) { FactoryGirl.create :user }
  let(:payload) { {'people' => ['user1','user2','user3']} }

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

      it "should create request with given payload" do
        post :create, payload, valid_session
        Request.last.owner_id.should == user.id
      end
    end
  end
end
