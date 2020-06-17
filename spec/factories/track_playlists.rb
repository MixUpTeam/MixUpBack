FactoryBot.define do
  factory :track_playlist do
    added_by { nil }
    track_spotify_id { "MyString" }
    playlist { nil }
    is_played { false }
    is_playing { false }
  end
end
