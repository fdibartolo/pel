require 'spec_helper'

describe Request do
  it "should have an owner" do
    request = FactoryGirl.build :request, owner_id: nil
    request.valid?.should be_false
    request.errors.count.should == 1
    request.errors[:owner].should include "can't be blank"
  end
end
