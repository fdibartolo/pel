class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_authentication unless Rails.env.test?
  after_action :set_user_in_session

  def set_user_in_session
    unless session[:user_id]
      session[:user_id] = @opensso_user['uid'].first.split("@").first if @opensso_user['uid']
      puts "User in session: #{session[:user_id]}"
    end
  end

  def current_user
    @current_user ||= User.find_by(enterprise_id: session[:user_id]) if session[:user_id]
  end
end
