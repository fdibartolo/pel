class TemplatesController < ApplicationController
  skip_after_action :set_user_in_session
  
  def template
    render :template => 'templates/' + params[:path], :layout => nil
  end
end
