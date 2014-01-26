require 'spec_helper'

describe Api::PersonalEngagementListsController do
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

      it "should be success" do
        response.should be_success
      end

      it "should include all template questions" do
        @body['questions'].count.should == 2
        @body['questions'][0]['body'].should == @first_template_question.body
        @body['questions'][1]['body'].should == @second_template_question.body
      end
    end

    context "requesting a pel to be edited" do
      before :each do
        @pel = FactoryGirl.create :personal_engagement_list
        @first_question = FactoryGirl.build :question
        @pel.questions << @first_question
      end

      context "with invalid params" do
        it "should include error if id is invalid" do
          invalid_id = @pel.id + 1
          get :edit, { format: :json, id: invalid_id }, valid_session
          body = JSON.parse response.body
          body['errors'].count.should == 1
          body['errors'].should include "Cannot find PEL with id=#{invalid_id}"
        end
      end

      context "with valid params" do
        before :each do
          get :edit, { format: :json, id: @pel.to_param }, valid_session
          @body = JSON.parse response.body
        end

        it "should be success" do
          response.should be_success
        end

        it "should return pel as json" do
          @body['id'].should == @pel.id
          @body['questions'].count.should == 1
          @body['questions'][0]['body'].should == @first_question.body
        end
      end
    end

    context "creating a pel" do
      context "with invalid params" do
        let(:payload) { {'questions' => [
          {'body' => 'Q1', 'priority' => 1, 'score' => 4}, 
          {'body' => 'Q2', 'priority' => 1, 'score' => 7}
        ]} }

        it "should return 401 if no current_user" do
          post :create, payload
          response.status.should == 401
        end

        # it "should respond with code 422 ('Unprocessable Entity')" do
        #   post :create, payload, valid_session
        #   response.status.should == 422
        # end

        it "should not get saved" do
          expect {
            post :create, payload, valid_session
          }.to change(PersonalEngagementList, :count).by(0)
        end

        it "should return errors hash with given question error description" do
          post :create, payload, valid_session
          body = JSON.parse response.body
          body['errors'].count.should == 1
          body['errors'].should include 'Priority has already been taken'
        end

        it "should return errors hash with given pel error description" do
          payload['questions'][1]['priority'] = 3
          post :create, payload, valid_session
          body = JSON.parse response.body
          body['errors'].count.should == 1
          body['errors'].should include 'Questions priority cannot be greater than 2'
        end
      end

      context "with valid params" do
        let(:payload) { {'questions' => [
          {'body' => 'Q1', 'priority' => 1, 'score' => 4}, 
          {'body' => 'Q2', 'priority' => 2, 'score' => 7}
        ]} }

        it "should be success" do
          post :create, payload, valid_session
          response.should be_success
        end

        it "should return corresponding id" do
          post :create, payload, valid_session
          body = JSON.parse response.body
          body['id'].should == PersonalEngagementList.last.id
        end
      end
    end

    context "updating a pel" do
      context "with invalid params" do
        before :each do
          @pel = FactoryGirl.create :personal_engagement_list
          first_question = FactoryGirl.build :question
          @pel.questions << first_question

          @payload = {'id' => @pel.id, 'questions' => [
            {'body' => first_question.body, 'priority' => 1, 'score' => 0}
          ]}
        end

        it "should return 401 if no current_user" do
          patch :update, @payload
          response.status.should == 401
        end

        it "should include error if id is invalid" do
          @payload['id'] = @pel.id + 1
          patch :update, @payload, valid_session
          body = JSON.parse response.body
          body['errors'].count.should == 1
          body['errors'].should include "Cannot find PEL with id=#{@payload['id']}"
        end

        it "should return errors hash with given question error description" do
          patch :update, @payload, valid_session
          body = JSON.parse response.body
          body['errors'].count.should == 1
          body['errors'].should include 'Score must be greater than 0'
        end
      end

      context "with valid params" do
        before :each do
          @pel = FactoryGirl.create :personal_engagement_list
          first_question = FactoryGirl.build :question, body: 'Q1', priority: 1, score: 7
          second_question = FactoryGirl.build :question, body: 'Q2', priority: 2, score: 8
          @pel.questions << first_question
          @pel.questions << second_question

          @payload = {'id' => @pel.id, 'questions' => [
            {'body' => first_question.body, 'priority' => 2, 'score' => 10},
            {'body' => second_question.body, 'priority' => 1, 'score' => 8}
          ]}
        end

        it "should be success" do
          patch :update, @payload, valid_session
          response.should be_success
        end

        it "should return updated PEL" do
          patch :update, @payload, valid_session
          body = JSON.parse response.body
          body['questions'][0]['score'].should == 10
          body['questions'][0]['priority'].should == 2
          body['questions'][1]['score'].should == 8
          body['questions'][1]['priority'].should == 1
        end
      end
    end
  end
end
