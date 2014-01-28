module Api
  class RequestsController < BaseApiController
    before_action :check_ability, only: [:new, :create]

    def new
      @request = Request.new
    end
    
    def create
      @request = Request.new(owner: current_user)
      @invalid_recipients = @request.add_recipients_and_return_invalid request_params
      @request.save
    end

    private
    def valid_session?
      return head :unauthorized unless current_user
    end

    def check_ability
      return head :forbidden if cannot? :create, Request
    end

    def request_params
      params.require(:people)
    end
  end
end
