module Api
  class ApiController < ApplicationController
    before_action :authenticate_user!
    rescue_from ActionController::ParameterMissing, with: :missing_params_error_response
    # TODO: (note for the front)need to catch ActionDispatch::Http::Parameters::ParseError in axios

    def missing_params_error_response(exception)
      render json: {
        status: 'error',
        messages: [
          exception.message.capitalize
        ]
      }
    end

    def authenticate_user!
      if current_user
        @user = current_user
      else
        render json: {
          status: "error",
          messages: ["You have no access to this content or action"]
        }
      end
    end
  end
end
