require 'spec_helper'

describe Request do
  it "should have an owner" do
    request = FactoryGirl.build :request, owner_id: nil
    request.valid?.should be_false
    request.errors.count.should == 1
    request.errors[:owner].should include "can't be blank"
  end

  describe "recipients" do
    let(:request) { FactoryGirl.build :request }
    let(:user) { FactoryGirl.create :user, enterprise_id: 'valid.user' }

    before :each do
      eids = [user.enterprise_id, 'invalid.eid', user.enterprise_id]
      @invalid_eids = request.add_recipients_and_return_invalid eids
    end

    it "duplicates should be discarded" do
      request.recipients.count.should == 1
      request.recipients.first.should eq user
    end

    it "valid should get added" do
      request.recipients.count.should == 1
      request.recipients.first.should eq user
    end

    it "invalid should be returned" do
      @invalid_eids.count.should == 1
      @invalid_eids.first.should == 'invalid.eid'
    end
  end

  it "should return requisition for given user" do
    owner = FactoryGirl.create :user, enterprise_id: 'owner'
    request = FactoryGirl.create :request, owner: owner
    current_user = FactoryGirl.create :user
    requisition = FactoryGirl.create :requisition, request_id: request.id, user_id: current_user.id
    FactoryGirl.create :requisition, request_id: request.id, user_id: owner.id

    user_requisition = request.requisition_for current_user
    user_requisition.should be_a Requisition
    user_requisition.user_id.should == current_user.id
    user_requisition.request_id.should == request.id
  end
end
