module Api
  class BaseController < ActionController::API
    include Pagy::Backend
    rescue_from ActionController::RoutingError, with: :render_not_found

    before_action :authenticate_api_key

    def authenticate_api_key
      unless request.headers['x-api-key'] == ENV.fetch('X_API_KEY')
        render json: { message: 'Not authorized' }, status: 401 and return
      end
    end

    def render_not_found
      render json: {}, status: :not_found
    end
  end
end
