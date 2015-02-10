class CatRentalRequestsController < ApplicationController

  def new
    render :new
  end

  def create
    rental = CatRentalRequest.new(rental_params)
    if rental.save
      redirect_to cat_url(rental_params[:cat_id])
    else
      render :new
    end
  end

  def approve
    rental = CatRentalRequest.find_by(cat_id: params[:id])
    rental.approve!
    redirect_to cat_url(params[:id])
  end

  def deny
    rental = CatRentalRequest.find_by(cat_id: params[:id])
    rental.deny!
    redirect_to cat_url(params[:id])
  end

  private
  def rental_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end

end
