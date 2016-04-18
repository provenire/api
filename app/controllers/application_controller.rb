class ApplicationController < ActionController::Base
  include JSONAPI::ActsAsResourceController


  # Auth
  before_action :authenticate


  # TODO: What's the right way to handle this?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session


  # Current User
  def current_user
    @current_user ||= begin
      AuthToken.new(token: auth_token).current_user
    rescue
      nil
    end
  end


  # Authenticate
  def authenticate
    render_unauthorized! unless current_user
  end


  # Add context
  def context
    { current_user: current_user }
  end


  # Auth Token
  def auth_token
    params[:token] || request.headers['Authorization'].split.last
  end


  # Error response
  def render_error!(details: "Bad Request", title: "Bad Request", status: :bad_request)
    render json: {
      errors: [{
        status: Rack::Utils.status_code(status),
        title: title,
        details: details
      }]
    }, status: status
  end


  # Unauthorized request
  def render_unauthorized!
    render_error!(details: "Invalid credentials", title: "Unauthorized", status: :unauthorized)
  end
end
