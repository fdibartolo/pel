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

  it "should build questions from params" do
    params = {'questions' => [
      {'body' => 'Q1', 'priority' => 1, 'score' => 4}, 
      {'body' => 'Q2', 'priority' => 1, 'score' => 7}
    ]}

    pel = FactoryGirl.create :personal_engagement_list
    pel.build_questions_from params['questions']
    pel.questions.should have(2).items
    pel.questions.first.body.should == 'Q1'
    pel.questions.last.score.should == 7
  end

  it "should update questions from params" do
    params = {'questions' => [
      {'body' => 'Q1', 'score' => 4, 'priority' => 1, 'comments' => 'lets go'}
    ]}

    pel = FactoryGirl.create :personal_engagement_list
    pel.questions << FactoryGirl.build(:question, body: 'Q1', score: 1, comments: 'hey ho')
    pel.update_questions_from params['questions']
    pel.questions.first.priority.should == 1
    pel.questions.first.score.should == 4
    pel.questions.first.comments.should == 'lets go'
  end

  it "should be able to reset question priorities" do
    pel = FactoryGirl.create :personal_engagement_list
    pel.questions << FactoryGirl.build(:question, body: 'Q1', priority: 1)
    pel.questions << FactoryGirl.build(:question, body: 'Q2', priority: 2)

    pel.save!
    pel.reset_priorities
    pel.reload
    pel.questions.first.priority.should be_nil
    pel.questions.last.priority.should be_nil
  end
end