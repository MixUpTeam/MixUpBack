class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
    add_index :playlists, :name
  end
end
