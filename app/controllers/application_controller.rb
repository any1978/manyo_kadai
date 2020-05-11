class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    if current_user == nil
      flash[:notice] = "ログインしてください"
      redirect_to new_session_path
    end
  end

end
