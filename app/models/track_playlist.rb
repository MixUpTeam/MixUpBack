class TrackPlaylist < ApplicationRecord
  belongs_to :added_by
  belongs_to :playlist
end
