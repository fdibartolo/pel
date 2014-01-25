require 'spec_helper'

describe Role do
  it "must have a name" do
    role = FactoryGirl.build :role, name: nil
    role.valid?.should be_false
    role.errors.count.should == 1
    role.errors[:name].should include "can't be blank"
  end

  it "name must be unique" do
    FactoryGirl.create :role, name: 'Admin'
    role = FactoryGirl.build :role, name: 'Admin'
    role.valid?.should be_false
    role.errors.count.should == 1
    role.errors[:name].should include "has already been taken"
  end
end
