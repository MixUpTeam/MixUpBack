require "rails_helper"

RSpec.describe TrackPlaylistsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/track_playlists").to route_to("track_playlists#index")
    end

    it "routes to #show" do
      expect(:get => "/track_playlists/1").to route_to("track_playlists#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/track_playlists").to route_to("track_playlists#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/track_playlists/1").to route_to("track_playlists#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/track_playlists/1").to route_to("track_playlists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/track_playlists/1").to route_to("track_playlists#destroy", :id => "1")
    end
  end
end
