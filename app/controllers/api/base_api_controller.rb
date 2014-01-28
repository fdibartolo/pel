module Api
  class BaseApiController < ApplicationController
    respond_to :json
    before_action :valid_session?
  end
end