require 'rails_helper'

RSpec.describe "Playlists", type: :request do
  before(:each) do
    @user_1 = create(:user_1)
    @playlist = create(:playlist, owner: @user_1)
    @random_name = "some random name"
    @inexistant_id = 1000
  end

  describe "GET /api/v1/playlists/id" do
    it " responses with status success, owner.id and name when params good" do
      get api_v1_playlist_path(@playlist)
      expect(JSON.parse(response.body)["status"]).to eq("success")
      expect(JSON.parse(response.body)["owner"]["id"]).to eq(@user_1.id)
      expect(JSON.parse(response.body)["name"]).to eq(@playlist.name)
    end

    it "returns status error and error message for inexistant record" do
      get api_v1_playlist_path(@inexistant_id)
      expect(JSON.parse(response.body)["status"]).to eq("error")
      expect(JSON.parse(response.body)["messages"].length).to be >= 1
    end
  end

  describe "POST /api/v1/playlists/" do
    it " responses with status success, owner.id and name when params good" do
      post api_v1_playlists_path, params: {
        playlist: {
          owner_id: @user_1.id,
          name: @random_name
        }
      }
      expect(JSON.parse(response.body)["status"]).to eq("success")
      expect(JSON.parse(response.body)["owner"]["id"]).to eq(@user_1.id)
      expect(JSON.parse(response.body)["name"]).to eq(@random_name)
    end

    it "returns status error and error message in case of error" do
      post api_v1_playlists_path(1), params: {
        some_unpermitted_params: {
          owner_id: @inexistant_id,
          name: "some random playlist name"
        }
      }
      expect(JSON.parse(response.body)["status"]).to eq("error")
      expect(JSON.parse(response.body)["messages"].length).to be >= 1
    end
  end
end
