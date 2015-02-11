class SessionsController < ApplicationController
  before_action :require_signed_in, only: :show

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(session_params[:user_name], session_params[:password])
    if user
      log_in(user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    log_out(current_user)
    redirect_to new_session_url
  end

  def index
    @user_sessions = current_user.session_tokens
    render :index
  end

  def end_session
    token = current_user.session_tokens.find_by(session_token: params[:token])

    if token.session_token == session[:token]
      log_out(current_user)
      redirect_to new_session_url
    else
      token.destroy
      redirect_to sessions_url
    end
  end

  private
  def session_params
    params.require(:session).permit(:user_name, :password)
  end

end
