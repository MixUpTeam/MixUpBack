class Playlist < ApplicationRecord
 belongs_to :owner, class_name: 'User'
 has_many :track_playlists, dependent: :destroy

 def owner_username
  owner.username
 end

 def tracks
  track_playlists.map { |tp| tp.track_spotify_id }
 end
end
