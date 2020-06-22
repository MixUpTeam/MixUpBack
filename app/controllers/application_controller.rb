class ApplicationController < ActionController::API
  def single_track_playlist_response(track_playlist)
    has_voted_up = User.first.voted_up_on? track_playlist # TODO: To be modified with current_user
    has_voted_down = User.first.voted_down_on? track_playlist # TODO: To be modified with current_user

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
