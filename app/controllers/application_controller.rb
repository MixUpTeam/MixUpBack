class ApplicationController < ActionController::API
  def single_track_playlist_response(track_playlist)
    track_playlist.attributes.except("added_by_id").merge({
      status: "success",
      added_by: {
        id: track_playlist.added_by_id,
        username: track_playlist.added_by_username
      }
    })
  end
end
