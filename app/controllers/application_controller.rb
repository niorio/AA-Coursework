class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def log_in(user)
    session[:token] = user.create_session_token
  end

  def log_out(user)
    destroy_session_token
    session[:token] = nil
  end

  def current_user
    return nil unless session[:token]
    return @curr_user if @curr_user
    token = SessionToken.find_by(session_token: session[:token])
    return nil if token.nil?
    token.user

  end

  def signed_in?
    !!current_user
  end

  def require_signed_in
    redirect_to new_session_url unless signed_in?
  end

  def destroy_session_token
    SessionToken.find_by(session_token: session[:token]).destroy
  end

  helper_method :current_user, :signed_in?

end
