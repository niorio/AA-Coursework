class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?


  private
  def current_user
    return nil unless session[:token]
    User.find_by(session_token: session[:token])
  end

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    session[:token] = user.reset_session_token!
  end

  def log_out!
    current_user.reset_session_token! if current_user
    session[:token] = nil
  end

  def must_be_signed_in
    redirect_to new_session_url unless logged_in?
  end
end
