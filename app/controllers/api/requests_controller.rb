module Api
  class RequestsController < ApplicationController
    respond_to :json
    before_action :valid_session?
    before_action :create_request, only: :create

    def create
      @request.owner_id = current_user.id
      head :ok if @request.save
    end

    private
    def valid_session?
      return head :unauthorized unless current_user
    end

    def create_request
      request_params
      return head :forbidden if cannot? :create, Request

      @request = Request.new
    end

    def request_params
      params.require(:people)
    end
  end
end
