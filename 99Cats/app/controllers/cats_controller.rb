class CatsController < ApplicationController
  before_action :require_signed_in
  before_action :must_own_cat, only: [:edit, :update]

  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.owner = current_user
    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat.id)
    else
      render :edit
    end
  end

  def must_own_cat
    cat = Cat.find(params[:id])
    redirect_to cats_url unless cat.owner == current_user
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :color, :birth_date, :description, :sex)
  end

end
