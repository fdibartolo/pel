require 'spec_helper'

describe HomeController do
  before :each do
    @user = FactoryGirl.create :user
  end

  def valid_session
    { enterprise_id: @user.enterprise_id }
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', nil, valid_session
      response.should be_success
    end
  end
end
