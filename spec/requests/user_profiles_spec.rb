require 'rails_helper'

RSpec.describe "UserProfiles", type: :request do
  describe "GET /api/v1//user_profiles" do
    it "works! (now write some real specs)" do
      get api_v1_user_profiles_path
      expect(response).to have_http_status(200)
    end
  end
end
