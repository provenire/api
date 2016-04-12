class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:token_auth]


  # Handle Auth
  def token_auth
    user = authenticate_user!
    if user
      render_token(user)
    else
      unauthorized!
    end
  end

  def token_refresh
    payload = AuthToken.new(token: auth_token).payload
    if payload["user_id"] == current_user.id
      render_token(current_user)
    else
      unauthorized!
    end
  end


  private

  def auth_params # TODO: Why can I not require 2 parameters?
    [params.require(:email), params.require(:password)]
  end

  def authenticate_user!
    User.authenticate(*auth_params)
  end

  def render_token(user)
    render json: { token: AuthToken.new(payload: { user_id: user.id, role: user.role }).token }, status: :created
  end
end
