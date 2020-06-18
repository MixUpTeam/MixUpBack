class TrackPlaylistsController < ApplicationController
  before_action :set_track_playlist, only: [:show, :update, :destroy]

  # GET /track_playlists
  def index
    @track_playlists = TrackPlaylist.all

    render json: @track_playlists
  end

  # GET /track_playlists/1
  def show
    render json: @track_playlist
  end

  # POST /track_playlists
  def create
    @track_playlist = TrackPlaylist.new(track_playlist_params)
 
    if @track_playlist.save
      render json: {
        id: @track_playlist.id,
        track_spotify_id: @track_playlist.track_spotify_id,
        up_votes: nil,
        down_votes: nil,
        user_already_voted_on_entry: false,
        added_by: {
          id: @track_playlist.added_by_id,
          username: @track_playlist.added_by.user_profile.username
        },
        is_played: @track_playlist.is_played,
        is_playing: @track_playlist.is_playing,
        created_at: @track_playlist.created_at
        }, 
        status: :created, location: @track_playlist
    else
      render json: @track_playlist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /track_playlists/1
  def update
    if @track_playlist.update(track_playlist_params)
      render json: @track_playlist
    else
      render json: @track_playlist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /track_playlists/1
  def destroy
    @track_playlist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track_playlist
      @track_playlist = TrackPlaylist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def track_playlist_params
      params.require(:track_playlist).permit(:added_by_id, :track_spotify_id, :playlist_id, :is_played, :is_playing)
    end
end
