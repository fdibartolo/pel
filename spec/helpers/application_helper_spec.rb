require 'spec_helper'

describe ApplicationHelper do
  it "should count the number of request for user in session" do
    user = FactoryGirl.create :user
    view.stub(:current_user).and_return(user) 

    owner = FactoryGirl.create :user, enterprise_id: 'owner'
    first_request = FactoryGirl.create :request, owner: owner
    second_request = FactoryGirl.create :request, owner: owner
    user.requests << first_request << second_request

    helper.inbox_count.should == 2
  end
end
