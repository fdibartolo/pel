require 'spec_helper'

describe PersonalEngagementList do
  before :each do
    @pel = FactoryGirl.create :personal_engagement_list
    @first_question = FactoryGirl.build :question
    @pel.questions << @first_question
  end

  context "with one question" do
    it "priority cannot be negative" do
      @first_question.priority = -1
      @pel.valid?.should be_false
      @pel.errors[:questions].should include "priority must be greater than 0"
    end

    it "priority cannot be greater than 1" do
      @first_question.priority = 2
      @pel.valid?.should be_false
      @pel.errors[:questions].should include "priority cannot be greater than 1"
    end
  end

  context "with two questions" do
    before :each do
      @pel.questions << FactoryGirl.build(:question)
    end

    it "priority cannot be greater than 2" do
      @first_question.priority = 4
      @pel.valid?.should be_false
      @pel.errors[:questions].should include "priority cannot be greater than 2"
    end

    it "priority cannot be the same for both" do
      @pel.questions.each {|q| q.priority = 1}
      @pel.valid?.should be_false
      @pel.errors[:'questions.priority'].should include "has already been taken"
    end
  end
end