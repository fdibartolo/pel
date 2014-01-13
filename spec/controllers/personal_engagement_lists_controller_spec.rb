require 'spec_helper'

describe PersonalEngagementListsController do
  context "for current user" do
    def valid_session
      { enterprise_id: user.enterprise_id }
    end

    let(:user) { FactoryGirl.create :user }

    context "with one pel" do
      let(:pel) { FactoryGirl.create :personal_engagement_list, user_id: user.id }
      let(:first_question) { FactoryGirl.build :question, body: 'Q1', priority: 1 }
      let(:second_question) { FactoryGirl.build :question, body: 'Q2', priority: 2 }

      before :each do
        pel.questions << first_question << second_question

        get :pels_for_current_user, { format: :json }, valid_session
        @body = JSON.parse response.body
      end
      
      it "response should be success" do
        response.should be_success
      end

      it "should return correct number serialized" do
        @body.should have(1).items
        @body[0]['id'].should == pel.id
      end

      it "should return corresponding questions serialized" do
        json_pel = @body[0]
        json_pel['questions'].should have(2).items
        json_pel['questions'][0]['body'].should == first_question.body
        json_pel['questions'][1]['priority'].should == second_question.priority
      end
    end

    context "requesting a template pel to be created" do
      before :each do
        @first_template_question = FactoryGirl.create :template_question, body: 'Q1'
        @second_template_question = FactoryGirl.create :template_question, body: 'Q2'

        get :new, { format: :json }, valid_session
        @body = JSON.parse response.body
      end

      it "response should be success" do
        response.should be_success
      end

      it "should include all template questions" do
        @body['questions'].count.should == 2
        @body['questions'][0]['body'].should == @first_template_question.body
        @body['questions'][1]['body'].should == @second_template_question.body
      end
    end
  end
end
