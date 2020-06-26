class TrackPlaylist < ApplicationRecord
  validates :track_spotify_id, presence: true

  belongs_to :added_by, class_name: 'User'
  belongs_to :playlist

  acts_as_votable

  scope :in_queue, -> { where(is_played: false, is_playing: false).order(cached_votes_score: :desc) }
  scope :history, -> { where(is_played: true, is_playing: false) }

  def added_by_username
    added_by.username
  end
end
