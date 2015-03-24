class NotesController < ApplicationController
  before_action :must_be_signed_in

  def create
    @note = Note.new(note_params)
    @note.user_id= current_user.id
    @note.save
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note=Note.find(params[:id])
    track_id = @note.track_id
    @note.destroy
    redirect_to track_url(track_id)
  end

  private
  def note_params
    params.require(:note).permit(:content, :track_id)
  end

end
