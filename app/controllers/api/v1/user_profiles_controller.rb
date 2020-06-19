module Api
  module V1
    class UserProfilesController < Api::ApiController
      before_action :set_user_profile, only: %i[show update destroy]

      def index
        @user_profiles = UserProfile.all

        render json: @user_profiles
      end

      def show
        render json: @user_profile
      end

      def create
        @user_profile = UserProfile.new(user_profile_params)

        if @user_profile.save
          render json: @user_profile, status: :created
        else
          render json: @user_profile.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user_profile.update(user_profile_params)
          render json: @user_profile
        else
          render json: @user_profile.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user_profile.destroy
      end

      private

      def set_user_profile
        @user_profile = UserProfile.find(params[:id])
      end

      def user_profile_params
        params.require(:user_profile).permit(:username, :user_id)
      end
    end
  end
end
