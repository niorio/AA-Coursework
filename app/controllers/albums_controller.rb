class AlbumsController < ApplicationController
  before_action :must_be_signed_in

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album.id)
    else
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    band_id = @album.band_id
    @album.destroy
    redirect_to band_url(band_id)
  end

  private
  def album_params
    params.require(:album).permit(:title, :band_id, :style)
  end


end
