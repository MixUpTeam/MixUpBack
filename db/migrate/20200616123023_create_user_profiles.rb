class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.string :username, null: false, default: ""
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :user_profiles, :username
  end
end
