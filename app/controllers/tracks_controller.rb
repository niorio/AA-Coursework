class TracksController < ApplicationController
  before_action :must_be_signed_in


  def new
    album = Album.find(params[:album_id])
    @track = album.tracks.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track.id)
    else
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    album_id = @track.album_id
    @track.destroy
    redirect_to album_url(album_id)
  end


  private
  def track_params
    params.require(:track).permit(:title, :bonus, :album_id, :lyrics)
  end




end
