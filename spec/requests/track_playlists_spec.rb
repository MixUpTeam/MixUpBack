require 'rails_helper'

RSpec.describe "TrackPlaylists", type: :request do
  before(:each) do
    user_1 = create(:user_1)
    @user_2 = create(:user_2)
    @playlist = create(:playlist, owner: user_1)
    @track_playlist = create(:track_playlist, added_by: user_1, playlist: @playlist)
    @original_score = @track_playlist.cached_votes_score
    @track_spotify_id = "some_random_spotify_id"
    @inexistant_id = 666
  end

  describe "POST /api/v1/track_playlists" do
    it "returns status success with new record info" do
      post api_v1_track_playlists_path, params: {
        "track_playlist": {
          "added_by_id": @user_2.id,
          "playlist_id": @playlist.id,
          "track_spotify_id": @track_spotify_id
        }
      }
      expect(JSON.parse(response.body)["status"]).to eq("success")
      expect(JSON.parse(response.body)["added_by"]["id"]).to eq(@user_2.id)
      expect(JSON.parse(response.body)["playlist_id"]).to eq(@playlist.id)
      expect(JSON.parse(response.body)["track_spotify_id"]).to eq(@track_spotify_id)
    end

    it "returns status error and error message in case of error" do
      post api_v1_track_playlists_path, params: { irrelevant_param_1: "some string" }
      expect(JSON.parse(response.body)["status"]).to eq("error")
      expect(JSON.parse(response.body)["messages"].length).to be >= 1
    end
  end

  describe "DELETE /api/v1/track_playlists/id" do
    it "returns confirmation info when successfully delete" do
      delete api_v1_track_playlist_path(@track_playlist)
      expect(JSON.parse(response.body)["status"]).to eq("success")
      expect(JSON.parse(response.body)["id"]).to eq(@track_playlist.id)
    end

    it "returns status error and error message in case of error" do
      delete api_v1_track_playlist_path(@inexistant_id)
      expect(JSON.parse(response.body)["status"]).to eq("error")
      expect(JSON.parse(response.body)["messages"].length).to be >= 1
    end
  end

  describe "POST /api/v1/track_playlists/id/up_vote OR down_vote" do
    it "returns success status and increase score by one for up vote" do
      post api_v1_track_playlist_up_vote_path(@track_playlist), params: {
        "track_playlist": {
          "voted_by_id": @user_2.id
        }
      }
      expect(JSON.parse(response.body)["status"]).to eq("success")
      expect(JSON.parse(response.body)["score"]).to eq(@original_score + 1 )
    end

    it "returns success status and decrease score by one for down vote" do
      post api_v1_track_playlist_down_vote_path(@track_playlist), params: {
        "track_playlist": {
          "voted_by_id": @user_2.id
        }
      }
      expect(JSON.parse(response.body)["status"]).to eq("success")
      expect(JSON.parse(response.body)["score"]).to eq(@original_score - 1 )
    end

    it "returns status error and error message in case of error" do
      post api_v1_track_playlist_down_vote_path(@track_playlist), params: {
        "track_playlist": {
          "voted_by_id": @inexistant_id
        }
      }
      expect(JSON.parse(response.body)["status"]).to eq("error")
      expect(JSON.parse(response.body)["messages"].length).to be >= 1
    end
  end
end
