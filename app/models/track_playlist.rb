class TrackPlaylist < ApplicationRecord
	validates :track_spotify_id, presence: true

  belongs_to :added_by, class_name: 'User'
  belongs_to :playlist
end
