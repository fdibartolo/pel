class HomeController < ApplicationController
  def index
    @enterprise_id = current_user.enterprise_id
  end
end
