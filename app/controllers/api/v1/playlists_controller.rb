module Api
  module V1
    class PlaylistsController < Api::ApiController
      before_action :set_playlist, only: %i[show update destroy]

      def index
        @playlists = Playlist.all

        render json: @playlists
      end

      def show
        render json: single_playlist_response(@playlist)
      end

      def create
        @playlist = Playlist.new(playlist_params)

        if @playlist.save
          render json: @playlist, status: :created
        else
          render json: @playlist.errors, status: :unprocessable_entity
        end
      end

      def update
        if @playlist.update(playlist_params)
          render json: @playlist
        else
          render json: @playlist.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @playlist.destroy
      end

      private

      def set_playlist
        @playlist = Playlist.find(params[:id])
      rescue StandardError
        render json: {
          status: 'error',
          messages: [
            'The record you ask for does not exist.'
          ]
        }
      end

      def playlist_params
        params.require(:playlist).permit(:name, :owner_id)
      end

      def single_playlist_response(playlist)
        {
          status: 'success',
          id: playlist.id,
          name: playlist.name,
          owner: {
            id: playlist.owner_id,
            username: playlist.owner_username
          },
          entries: playlist.track_playlists.map { |track_playlist| single_track_playlist_response(track_playlist) }
        }
      end
    end
  end
end
