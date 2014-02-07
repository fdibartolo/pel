module Api
  class RequestsController < BaseApiController
    before_action :check_ability, only: [:new, :create]

    def all_for_current_user
      @requests = current_user.requests  
    end

    def new
      @request = Request.new
    end
    
    def create
      @request = Request.new(owner: current_user)
      process_request
    end

    def update
      @request = Request.find_by(id: params[:id])
      return head :forbidden if cannot? :update, @request
      process_request
    end

    def submit_requisition
      check_mandatory_requisition_params
      @errors = []
      pel = PersonalEngagementList.find_by(id: params[:personal_engagement_list_id])
      @errors << "Cannot find PEL with id=#{params[:personal_engagement_list_id]}" unless pel
      @errors << "Cannot find Request with id=#{params[:id]}" unless current_user.request_ids.include? params[:id].to_i

      process_requisition_for pel unless @errors.any?
    end

    private
    def valid_session?
      return head :unauthorized unless current_user
    end

    def check_ability
      return head :forbidden if cannot? :create, Request
    end

    def process_request
      @invalid_recipients = @request.add_recipients_and_return_invalid request_params
      @request.message = params[:message] if params[:message]
      @request.save
    end

    def request_params
      params.require(:recipients)
    end

    def process_requisition_for pel
      @requisition = Request.find(params[:id]).requisitions.where(user_id: current_user.id).first
      @requisition.personal_engagement_list_id = pel.id
      @requisition.save!
    end

    def check_mandatory_requisition_params
      params.require(:personal_engagement_list_id)
    end
  end
end
