class CreateTrackPlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :track_playlists do |t|
      t.references :added_by, index: true, null: false, foreign_key: { to_table: :users }
      t.string :track_spotify_id
      t.references :playlist, null: false, foreign_key: true
      t.boolean :is_played, default: false
      t.boolean :is_playing, default: false
      t.timestamps
    end
    add_index :track_playlists, :track_spotify_id
    add_index :track_playlists, :is_played
    add_index :track_playlists, :is_playing
  end
end
