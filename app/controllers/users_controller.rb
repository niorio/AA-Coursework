class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user.id)
    else
      render :new
    end

  end

  def show
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end



end
