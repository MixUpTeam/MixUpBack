class Playlist < ApplicationRecord
  validates :name, presence: true

  belongs_to :owner, class_name: 'User'
  has_many :track_playlists, dependent: :destroy

  def owner_username
    owner.username
  end

  def tracks
    track_playlists.map(&:track_spotify_id)
  end

  def current_track
    if track_playlists.in_queue.length.zero?
      return track_playlist.first
    else
      return track_playlists.in_queue.first
    end
  end
end
