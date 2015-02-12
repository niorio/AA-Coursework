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
    @album = Album.find(params[:id])
    band_id = @album.band_id
    @album.destroy
    redirect_to band_url(band_id)
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album.id)
    else
      render :edit
    end
  end


  private
  def album_params
    params.require(:album).permit(:title, :band_id, :style)
  end


end
