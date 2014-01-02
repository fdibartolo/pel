require 'spec_helper'

describe Question do
  before :each do
    @pel = FactoryGirl.create :personal_engagement_list
    @question = FactoryGirl.build :question, personal_engagement_list_id: @pel.id
  end

  it "must belong to a personal engagement list" do
    @question.personal_engagement_list_id = nil
    @question.valid?.should be_false
    @question.errors.count.should == 1
    @question.errors[:personal_engagement_list_id].should include "can't be blank"
  end

  it "must have a body" do
    @question.body = nil
    @question.valid?.should be_false
    @question.errors.count.should == 1
    @question.errors[:body].should include "can't be blank"
  end

  describe "score" do
    it "cannot be less than 1" do
      @question.score = 0
      @question.valid?.should be_false
      @question.errors.count.should == 1
      @question.errors[:score].should include "must be greater than 0"
    end

    it "cannot be greater than 10" do
      @question.score = 11
      @question.valid?.should be_false
      @question.errors.count.should == 1
      @question.errors[:score].should include "must be less than or equal to 10"
    end
  end
end
