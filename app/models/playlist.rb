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
end
