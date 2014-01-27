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
      @invalid_eids = request.add_recipients_and_return_invalid [user.enterprise_id, 'invalid.eid']
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
end
