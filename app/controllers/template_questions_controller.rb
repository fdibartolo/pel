class TemplateQuestionsController < ApplicationController
  before_action :set_template_question, only: [:edit, :update, :destroy]

  def index
    @template_questions = TemplateQuestion.all
  end

  def new
    @template_question = TemplateQuestion.new
  end

  def edit
  end

  def create
    @template_question = TemplateQuestion.new(template_question_params)

    respond_to do |format|
      if @template_question.save
        format.html { redirect_to template_questions_path, notice: 'Template question was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @template_question.update(template_question_params)
        format.html { redirect_to template_questions_path, notice: 'Template question was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @template_question.destroy
    respond_to do |format|
      format.html { redirect_to template_questions_url }
    end
  end

  private
    def set_template_question
      @template_question = TemplateQuestion.find(params[:id])
    end

    def template_question_params
      params.require(:template_question).permit(:body)
    end
end
