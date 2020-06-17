# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_17_101548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_playlists_on_name"
    t.index ["owner_id"], name: "index_playlists_on_owner_id"
  end

  create_table "track_playlists", force: :cascade do |t|
    t.bigint "added_by_id", null: false
    t.string "track_spotify_id"
    t.bigint "playlist_id", null: false
    t.boolean "is_played", default: false
    t.boolean "is_playing", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["added_by_id"], name: "index_track_playlists_on_added_by_id"
    t.index ["is_played"], name: "index_track_playlists_on_is_played"
    t.index ["is_playing"], name: "index_track_playlists_on_is_playing"
    t.index ["playlist_id"], name: "index_track_playlists_on_playlist_id"
    t.index ["track_spotify_id"], name: "index_track_playlists_on_track_spotify_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
    t.index ["username"], name: "index_user_profiles_on_username"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "playlists", "users", column: "owner_id"
  add_foreign_key "track_playlists", "playlists"
  add_foreign_key "track_playlists", "users", column: "added_by_id"
  add_foreign_key "user_profiles", "users"
end
