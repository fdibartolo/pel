class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_authentication, except: [:health] unless Rails.env.test?
  before_action :set_user_in_session

  def set_user_in_session
    unless session[:enterprise_id] or @opensso_user.nil?
      session[:enterprise_id] = @opensso_user['uid'].first.split("@").first if @opensso_user['uid']
    end
  end

  def current_user
    @current_user ||= User.find_by(enterprise_id: session[:enterprise_id]) if session[:enterprise_id]
  end

  def signout
    session[:enterprise_id] = nil
    redirect_to logout_path
  end

  def health
    head :ok, message: "Site is up and running!"
  end
end
