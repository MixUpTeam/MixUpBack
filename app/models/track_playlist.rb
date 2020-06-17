class TrackPlaylist < ApplicationRecord
  belongs_to :added_by, class_name: 'User'
  belongs_to :playlist
end
