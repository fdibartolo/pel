class PersonalEngagementListsController < ApplicationController
  respond_to :json

  def pels_for_current_user
    @pels = PersonalEngagementList.where(user_id: current_user.id)
  end

  def new
    @pel = PersonalEngagementList.new
    TemplateQuestion.all.each do |template_question|
      @pel.questions.build(attributes: { body: template_question.body })
    end
  end

  def create
    @pel = PersonalEngagementList.create!(user: current_user) if current_user
    return head :bad_request unless @pel

    @pel.build_questions_from personal_engagement_list_params

    @pel.questions.each {|q| q.save}
    @pel.save
  end

  private
  def personal_engagement_list_params
    params.require(:questions).each {|q| q.keep_if {|k,v| %w[body priority score].include? k }}
  end
end
