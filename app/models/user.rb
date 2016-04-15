# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string
#  salt                            :string
#  slug                            :string           not null
#  uuid                            :uuid
#  name                            :string
#  description                     :string
#  company                         :string
#  location                        :string
#  role                            :string           default("user")
#  login_count                     :integer          default("0"), not null
#  created_at                      :datetime
#  updated_at                      :datetime
#  activation_state                :string
#  activation_token                :string
#  activation_token_expires_at     :datetime
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  failed_logins_count             :integer          default("0")
#  lock_expires_at                 :datetime
#  unlock_token                    :string
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#  last_login_from_ip_address      :string
#
# Indexes
#
#  index_users_on_activation_token                     (activation_token)
#  index_users_on_email                                (email) UNIQUE
#  index_users_on_last_logout_at_and_last_activity_at  (last_logout_at,last_activity_at)
#  index_users_on_remember_me_token                    (remember_me_token)
#  index_users_on_reset_password_token                 (reset_password_token)
#  index_users_on_slug                                 (slug) UNIQUE
#  index_users_on_unlock_token                         (unlock_token)
#  index_users_on_uuid                                 (uuid) UNIQUE
#

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name


  # Set up sorcery
  authenticates_with_sorcery!


  # Validations
  validates :email, uniqueness: true
  validates :email, presence: true, on: :create
  validates :name,  presence: true, on: :create
  validates :name,  presence: true, on: :update, if: :password
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }, if: :password


  # Callbacks
  before_create :setup_new_account


  # Helpers
  def admin?
    role == 'admin'
  end

  def reactivate_account!
    return false unless activation_state == 'disabled'
    setup_activation && save!
    UserMailer.account_reactivated_email(self).deliver_later
  end


  private

  def setup_new_account
    self.name = ''
    setup_activation
  end
end
