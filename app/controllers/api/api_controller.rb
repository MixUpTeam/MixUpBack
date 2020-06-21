module Api
  class ApiController < ApplicationController
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
  end
end
