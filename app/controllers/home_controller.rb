class HomeController < ApplicationController
  def index
    @username = current_user.enterprise_id
  end
end
