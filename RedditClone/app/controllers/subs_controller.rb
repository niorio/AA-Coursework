class SubsController < ApplicationController
  before_action :current_user_must_be_moderator, only: :edit
  before_filter :must_be_logged_in, except: [:index, :show]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      flash[:notice] = "'#{@sub.title}' created"
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      flash[:notice] = "'#{@sub.title}' updated"
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    flash[:notice] = "'#{@sub.title}' deleted"
    #redirects
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def current_user_must_be_moderator
    unless current_user == @sub.moderator
      flash[:notice] = "Only the moderator can edit the sub"
      redirect_to sub_url(@sub)
    end
  end
end
