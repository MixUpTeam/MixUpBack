class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.references :owner, index: true, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
    add_index :playlists, :name
  end
end
