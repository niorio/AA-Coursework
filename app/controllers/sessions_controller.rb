class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username], params[:user][:password])

    if @user
      log_in(@user)
      redirect_to subs_url
    else
      @user = User.new
      @user.errors.add(:invalid, "credentials")
      render :new
    end
  end

  def destroy
    log_out
  end

end
