module Api
  class ApiController < ApplicationController
    before_action :authenticate_user!
    rescue_from ActionController::ParameterMissing, with: :missing_params_error_response

    def missing_params_error_response(exception)
      render json: {
        status: 'error',
        messages: [
          exception.message.capitalize
        ]
      }
    end

    def authenticate_user!
      if current_user
        @user = current_user
      else
        render json: {
          status: 'error',
          messages: ['You have no access to this content or action']
        }
      end
    end

    def single_track_playlist_response(track_playlist)
      has_voted_up = current_user.voted_up_on? track_playlist
      has_voted_down = current_user.voted_down_on? track_playlist

      track_playlist
        .attributes
        .except('added_by_id', 'cached_votes_total', 'cached_votes_up', 'cached_votes_down', 'cached_votes_score')
        .merge({
                 status: 'success',
                 added_by: {
                   id: track_playlist.added_by_id,
                   username: track_playlist.added_by_username
                 },
                 score: track_playlist.cached_votes_score,
                 has_voted_up: has_voted_up,
                 has_voted_down: has_voted_down
               })
    end

    def readable_validation_errors(resource)
      {
        status: 'error',
        messages: resource.errors.map { |k, v| "#{k.capitalize} #{v}" }
      }
    end
  end
end
