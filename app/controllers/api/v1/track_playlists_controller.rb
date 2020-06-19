module Api 
  module V1
    class TrackPlaylistsController < Api::ApiController
      before_action :set_track_playlist, only: [:show, :update, :destroy]

      def index
        @track_playlists = TrackPlaylist.all

        render json: @track_playlists
      end

      def show
        render json: @track_playlist
      end

      def create
        @track_playlist = TrackPlaylist.new(track_playlist_params)
    
        if @track_playlist.save
          render json: single_track_playlist_response(@track_playlist)
        else
          render json: readable_validation_errors(@track_playlist)
        end
      end

      def update
        if @track_playlist.update(track_playlist_params)
          render json: @track_playlist
        else
          render json: @track_playlist.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @track_playlist.destroy
      end

      private

      def set_track_playlist
        @track_playlist = TrackPlaylist.find(params[:id])
      end

      def track_playlist_params
        params.require(:track_playlist).permit(:added_by_id, :track_spotify_id, :playlist_id, :is_played, :is_playing)
      end
    end
  end
end
