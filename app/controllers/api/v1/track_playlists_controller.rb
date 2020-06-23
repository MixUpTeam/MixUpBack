module Api
  module V1
    class TrackPlaylistsController < Api::ApiController
      before_action :set_track_playlist, only: %i[show update destroy]
      before_action :set_track_playlist_for_votes, only: %i[up_vote down_vote]

      def index
        @track_playlists = TrackPlaylist.all

        render json: @track_playlists
      end

      def show
        render json: @track_playlist
      end

      def create
        @track_playlist = TrackPlaylist.new(track_playlist_params.merge(added_by: @user))

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
        render json: {
          status: 'success',
          id: @track_playlist.id,
          messages: ['The record has been deleted.']
        }
      end

      def up_vote
        @track_playlist.liked_by @user
        render json: single_track_playlist_response(@track_playlist)
      end

      def down_vote
        @track_playlist.downvote_from @user
        render json: single_track_playlist_response(@track_playlist)
      end

      private

      def set_track_playlist_for_votes
        @track_playlist = TrackPlaylist.find(params[:track_playlist_id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          status: 'error',
          messages: ['The record you are looking for does not exist.']
        }
      end

      def set_track_playlist
        @track_playlist = TrackPlaylist.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          status: 'error',
          messages: ['The record you are looking for does not exist.']
        }
      end

      def track_playlist_params
        params.require(:track_playlist).permit(:track_spotify_id, :playlist_id, :is_played, :is_playing)
      end
    end
  end
end
