class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:token_auth, :forgot_password, :reset_password]


  # Override
  def update
    can_update? ? super : render_unauthorized!
  end


  # Handle Auth
  def token_auth
    user = authenticate_user!
    if user
      render_token(user)
    else
      render_unauthorized!
    end
  end

  def token_refresh
    payload = AuthToken.new(token: auth_token).payload
    if payload["user_id"] == current_user.id
      render_token(current_user)
    else
      render_unauthorized!
    end
  end

  def forgot_password
    user = User.find_by_email(forgot_password_params)
    user.deliver_reset_password_instructions! if user
    render json: { message: "Password reset instructions have been sent." }, status: :ok
  end

  def reset_password # TODO: Clean this up
    user = User.load_from_reset_password_token(reset_password_params[:token])
    render_unauthorized! && return unless user
    render_error!(details: "Password confirmation required.") && return unless reset_password_params[:password_confirmation]
    unless reset_password_params[:password] == reset_password_params[:password_confirmation]
      render_error!(details: "Password and password confirmation must match") && return
    end
    user.password_confirmation = reset_password_params[:password_confirmation]
    if user.change_password!(reset_password_params[:password])
      render json: { message: "Password has been reset." }, status: :ok
    else
      render_error!(details: "Your password is too short. Must be 8 characters or longer.")
    end
  end


  private

  def auth_params # TODO: Why can I not require 2 parameters?
    [params.require(:email), params.require(:password)]
  end

  def forgot_password_params
    params.require(:email)
  end

  def reset_password_params
    params.require(:user).permit(:token, :password, :password_confirmation)
  end

  def authenticate_user!
    login(*auth_params)
  end

  def render_token(user)
    payload = { user_id: user.id, role: user.role }
    render json: { token: AuthToken.new(payload: payload).token }.merge(payload), status: :created
  end

  def can_update?
    params["id"] == current_user.id.to_s || current_user.admin?
  end
end
