class UserMailer < ApplicationMailer

  def activation_needed_email(user)
    @user = user
    @url  = "https://explore.provenire.io/register?token=#{user.activation_token}"

    mail to: user.email, subject: 'You have been invited to join Provenire'
  end

  def account_reactivated_email(user)
    @user = user
    @url  = "https://explore.provenire.io/register?token=#{user.activation_token}"

    mail to: user.email, subject: 'Your Provenire account has been reactivated'
  end

  def activation_success_email(user)
    @user = user
    @url  = "https://explore.provenire.io/login"

    mail to: user.email, subject: 'Welcome to Provenire!'
  end

  def reset_password_email(user)
    @user = user
    @url  = "https://explore.provenire.io/users/reset_password?token=#{user.reset_password_token}"

    mail to: user.email, subject: 'Provenire - Reset Password'
  end

end
