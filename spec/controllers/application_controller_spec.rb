require 'spec_helper'

describe ApplicationController do
  before :each do
    @user = FactoryGirl.create :user
  end

  def valid_session
    { enterprise_id: @user.enterprise_id }
  end

  it "should return success (to be called by CI box to check app running)" do
    get :health
    response.should be_success
  end

  it "should be able to signout" do
    get :signout, valid_session
    session[:enterprise_id].should be_nil
    response.should redirect_to logout_path
  end
end
