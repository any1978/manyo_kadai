class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def current_user
    # checks for a User based on the session’s user id that was stored when they logged in, and stores result in an instance variable
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
