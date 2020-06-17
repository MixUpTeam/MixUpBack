require 'faker'

TRACK_SPOTIFY_IDS = ["55p8TQ1ggGYOO1gLQrC52D",
"1sFstGV1Z3Aw5TDFCiT7vK",
"4rHIfYRQw6ittRQXAlurk0",
"1scwknKtBQpreYy6MSoJqJ",
"2PR4jVXzyjCky2PkONvipq",
"0cppqb4vQycORHNMxr8DGd",
"2uVNn2pFpDlx1XrFcEfary"]

puts "clearing records"

User.destroy_all

#################### User ####################

puts "generating users and profiles"

n = 1
10.times do
	u =	User.create(email: "yopmail#{n}@gmail.com", password: "blabla")
	u.user_profile.update(username: Faker::ProgrammingLanguage.unique.name)
	n += 1
end

puts "#{User.count} users generated"

#################### Playlist ####################

puts "generating playlists"

30.times do
	Playlist.create(name: Faker::Music.genre, owner: User.all.sample)
end

puts "#{Playlist.count} playlists generated"


#################### TrackPlaylist ####################

puts "generating trackplaylists"

1000.times do
	TrackPlaylist.create(added_by: User.all.sample, track_spotify_id: TRACK_SPOTIFY_IDS.sample, playlist: Playlist.all.sample)
end

puts "#{TrackPlaylist.count} trackplaylists generated"