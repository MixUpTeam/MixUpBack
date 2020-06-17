require 'rails_helper'

RSpec.describe "TrackPlaylists", type: :request do
  describe "GET /track_playlists" do
    it "works! (now write some real specs)" do
      get track_playlists_path
      expect(response).to have_http_status(200)
    end
  end
end
