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
end
