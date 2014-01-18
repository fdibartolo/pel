class PersonalEngagementListsController < ApplicationController
  respond_to :json
  before_action :valid_session?

  def pels_for_current_user
    @pels = PersonalEngagementList.where(user_id: current_user.id)
  end

  def new
    @pel = PersonalEngagementList.new
    TemplateQuestion.all.each do |template_question|
      @pel.questions.build(attributes: { body: template_question.body })
    end
  end

  def edit
    @errors = []
    if params[:id]
      @pel = PersonalEngagementList.find_by(id: params[:id])
      @errors << "Cannot find PEL with id=#{params[:id]}" unless @pel
    else
      @errors << "Param <id> must be provided"
    end
  end

  def create
    @pel = PersonalEngagementList.create!(user: current_user)
    @pel.build_questions_from personal_engagement_list_params

    begin
      @errors = []
      cascade_save_in_transaction
    rescue Exception => e
      @pel.destroy
    end
  end

  def update
    @errors = []
    if params[:id]
      @pel = PersonalEngagementList.find_by(id: params[:id])
      if @pel
        @pel.update_questions_from personal_engagement_list_params

        begin
          cascade_save_in_transaction
        rescue
        end
      else
        @errors << "Cannot find PEL with id=#{params[:id]}"
      end
    else
      @errors << "Param <id> must be provided"
    end
  end

  private
  def valid_session?
    return head :unauthorized unless current_user
  end

  def personal_engagement_list_params
    params.require(:questions).each {|q| q.keep_if {|k,v| %w[body priority score comments].include? k }}
  end

  def cascade_save_in_transaction
    PersonalEngagementList.transaction do
      @pel.questions.each do |q|
        unless q.save
          @errors.concat(q.errors.full_messages).uniq
          raise ActiveRecord::RollbackException
        end
      end
      unless @pel.save
        @errors.concat(@pel.errors.full_messages).uniq
        raise ActiveRecord::RollbackException
      end
    end
  end
end
