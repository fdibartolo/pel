require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.build :user
  end

  it "must have an enterprise id" do
    @user.enterprise_id = nil
    @user.valid?.should be_false
    @user.errors.count.should == 1
    @user.errors[:enterprise_id].should include "can't be blank"
  end

  describe ".has_role?" do
    before :each do
      @role = FactoryGirl.create :role
      @user.roles << @role
    end

    it "should return true if role belongs to user" do
      @user.has_role?(@role.name).should be_true
    end
    
    it "should return false if role does not belong to user" do
      @user.has_role?('unexistent').should be_false
    end
  end
end
