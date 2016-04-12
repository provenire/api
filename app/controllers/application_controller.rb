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
    unauthorized! unless current_user
  end


  # Add context
  def context
    { current_user: current_user }
  end


  # Auth Token
  def auth_token
    params[:token] || request.headers['Authorization'].split.last
  end


  # Unauthorized request
  def unauthorized!
    render json: { errors: [{ status: 401, title: "Unauthorized", details: "Invalid credentials" }] }, status: :unauthorized
  end
end
