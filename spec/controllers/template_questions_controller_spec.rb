require 'spec_helper'

describe TemplateQuestionsController do
  before :each do
    @user = FactoryGirl.create :user
    @user.roles << FactoryGirl.create(:role, name: AdminRole)
  end

  # def valid_session
  #   { enterprise_id: @user.enterprise_id }
  # end

  let(:valid_attributes) { { "body" => "Some question" } }
  let(:valid_session) { { enterprise_id: @user.enterprise_id } }

  describe "GET index" do
    it "assigns all template_questions as @template_questions" do
      template_question = FactoryGirl.create :template_question
      get :index, {}, valid_session
      assigns(:template_questions).should eq([template_question])
    end
  end

  describe "GET new" do
    it "assigns a new template_question as @template_question" do
      get :new, {}, valid_session
      assigns(:template_question).should be_a_new(TemplateQuestion)
    end
  end

  describe "GET edit" do
    it "assigns the requested template_question as @template_question" do
      template_question = FactoryGirl.create :template_question
      get :edit, {:id => template_question.to_param}, valid_session
      assigns(:template_question).should eq(template_question)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TemplateQuestion" do
        expect {
          post :create, {:template_question => valid_attributes}, valid_session
        }.to change(TemplateQuestion, :count).by(1)
      end

      it "assigns a newly created template_question as @template_question" do
        post :create, {:template_question => valid_attributes}, valid_session
        assigns(:template_question).should be_a(TemplateQuestion)
        assigns(:template_question).should be_persisted
      end

      it "redirects to template questions index" do
        post :create, {:template_question => valid_attributes}, valid_session
        response.should redirect_to(template_questions_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved template_question as @template_question" do
        TemplateQuestion.any_instance.stub(:save).and_return(false)
        post :create, {:template_question => { "body" => "invalid value" }}, valid_session
        assigns(:template_question).should be_a_new(TemplateQuestion)
      end

      it "re-renders the 'new' template" do
        TemplateQuestion.any_instance.stub(:save).and_return(false)
        post :create, {:template_question => { "body" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested template_question" do
        template_question = FactoryGirl.create :template_question
        TemplateQuestion.any_instance.should_receive(:update).with({ "body" => "Some question" })
        put :update, {:id => template_question.to_param, :template_question => { "body" => "Some question" }}, valid_session
      end

      it "assigns the requested template_question as @template_question" do
        template_question = FactoryGirl.create :template_question
        put :update, {:id => template_question.to_param, :template_question => valid_attributes}, valid_session
        assigns(:template_question).should eq(template_question)
      end

      it "redirects to template question index" do
        template_question = FactoryGirl.create :template_question
        put :update, {:id => template_question.to_param, :template_question => valid_attributes}, valid_session
        response.should redirect_to(template_questions_path)
      end
    end

    describe "with invalid params" do
      it "assigns the template_question as @template_question" do
        template_question = FactoryGirl.create :template_question
        TemplateQuestion.any_instance.stub(:save).and_return(false)
        put :update, {:id => template_question.to_param, :template_question => { "body" => "invalid value" }}, valid_session
        assigns(:template_question).should eq(template_question)
      end

      it "re-renders the 'edit' template" do
        template_question = FactoryGirl.create :template_question
        TemplateQuestion.any_instance.stub(:save).and_return(false)
        put :update, {:id => template_question.to_param, :template_question => { "body" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested template_question" do
      template_question = FactoryGirl.create :template_question
      expect {
        delete :destroy, {:id => template_question.to_param}, valid_session
      }.to change(TemplateQuestion, :count).by(-1)
    end

    it "redirects to the template_questions list" do
      template_question = FactoryGirl.create :template_question
      delete :destroy, {:id => template_question.to_param}, valid_session
      response.should redirect_to(template_questions_url)
    end
  end
end
