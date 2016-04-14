class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:token_auth]


  # Override
  def update
    can_update? ? super : unauthorized!
  end


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
    payload = { user_id: user.id, role: user.role }
    render json: { token: AuthToken.new(payload: payload).token }.merge(payload), status: :created
  end

  def can_update?
    params["id"] == current_user.id.to_s || current_user.admin?
  end
end
