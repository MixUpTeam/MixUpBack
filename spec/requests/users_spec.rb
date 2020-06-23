require 'rails_helper'

RSpec.describe "User auth", type: :request do
  describe "post /users.json" do

    before(:all) do
      @current_number_of_users = User.all.count
    end

    it "creates user, returns id and token" do
      post user_registration_path, params: {
        user: {
          email: "random_email@yopmail.com",
          password: "111111"
        }
      }
      expect(response).to have_http_status(201)
      expect(User.all.count).to eq(@current_number_of_users+1)
      expect(JSON.parse(response.body)["id"]).to be_present
    end

    it "returns errors in case of validation error" do

      User.create(
        email: "random_email@yopmail.com",
        password: "111111"
      )

      post user_registration_path, params: {
        user: {
          email: "random_email@yopmail.com",
          password: "111111"
        }
      }

      expect(response).not_to have_http_status(201)
      expect(User.all.count).to eq(@current_number_of_users + 1)
      expect(JSON.parse(response.body)["errors"]).to be_present
    end
    
  end
end