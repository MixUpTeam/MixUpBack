require 'rails_helper'

RSpec.describe "User auth", type: :request do
  describe "post /users.json" do

    before(:all) do
      @current_number_of_users = User.all.count
    end

    it "creates user, returns id" do
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

  describe "post /users/sign_in.json" do

    before(:all) do
      @user = User.create(
        email: "random_email@yopmail.com",
        password: "111111"
      )
      @current_number_of_users = User.all.count
    end

    it "doesn't creates new user, returns id" do
      post new_user_session_path, params: {
        user: {
          email: @user.email,
          password: @user.password
        }
      }
      expect(response).to have_http_status(201)
      expect(User.all.count).to eq(@current_number_of_users)
      expect(JSON.parse(response.body)["id"]).to eq(@user.id)
    end

    it "returns errors in case of identification errors" do
      post new_user_session_path, params: {
        user: {
          email: @user.email,
          password: "#{@user.password}11"
        }
      }
      expect(JSON.parse(response.body)["error"]).to be_present
    end
    
  end

  describe "delete /users/sign_out.json" do
    it "returns 204 response with out body" do
      user = create(:user_1)
      sign_in user
      delete destroy_user_session_path(user)
      expect(response).to have_http_status(204)
    end   
  end
end