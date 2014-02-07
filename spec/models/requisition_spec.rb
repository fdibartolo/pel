require 'spec_helper'

describe Requisition do
  before :each do
    user = FactoryGirl.create :user
    request = FactoryGirl.create :request, owner_id: user.id
    @requisition = FactoryGirl.build :requisition, user_id: user.id, request_id: request.id
  end

  it "should belong to a request" do
    @requisition.request = nil
    @requisition.valid?.should be_false
    @requisition.errors.count.should == 1
    @requisition.errors[:request].should include "can't be blank"
  end

  it "should belong to a user" do
    @requisition.user = nil
    @requisition.valid?.should be_false
    @requisition.errors.count.should == 1
    @requisition.errors[:user].should include "can't be blank"
  end
end
