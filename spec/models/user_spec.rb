require 'spec_helper'

describe User do
  it "must have an enterprise id" do
    user = FactoryGirl.build :user, enterprise_id: nil
    user.valid?.should be_false
    user.errors.count.should == 1
    user.errors[:enterprise_id].should include "can't be blank"
  end
end
