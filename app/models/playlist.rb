class Playlist < ApplicationRecord
 belongs_to :owner, class_name: 'User'
 has_many :track_playlists, dependent: :destroy
end
