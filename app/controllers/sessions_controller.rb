class SessionsController < ApplicationController
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

  private
  def session_params
    params.require(:session).permit(:user_name, :password)
  end

end
