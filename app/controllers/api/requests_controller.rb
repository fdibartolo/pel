module Api
  class RequestsController < BaseApiController
    before_action :check_ability, only: [:new, :create]

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
  end
end
