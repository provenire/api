# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string
#  salt                            :string
#  name                            :string
#  description                     :string
#  company                         :string
#  location                        :string
#  role                            :string           default("user")
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
#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_unlock_token          (unlock_token)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not create when email, name not present" do
    user = FactoryGirl.build(:user, name: nil)
    assert_not user.save

    user = FactoryGirl.build(:user, email: nil)
    assert_not user.save
  end

  test "should not save when email not unique" do
    user = FactoryGirl.build(:user, email: "generic@email.com")
    assert user.save

    user2 = FactoryGirl.build(:user, email: "generic@email.com")
    assert_not user2.save
  end

  test "should setup_activation on create" do
    user = FactoryGirl.create(:user)
    assert_equal '', user.name
  end

  test "#admin? should return true if user is admin" do
    user = FactoryGirl.create(:user, role: "admin")
    assert user.admin?
  end

  test "#reactivate_account! should return false if user not disabled" do
    user = FactoryGirl.create(:user)
    assert_not user.reactivate_account!
  end

  test "#reactivate_account! should run setup_activation on disabled user" do
    user = FactoryGirl.create(:user)
    user.activation_state = 'disabled'
    user.activation_token = nil
    user.name = "TEST"
    user.save

    user.reactivate_account!
    assert user.activation_token
  end

  test "creating user should send activation mailer" do
    user = FactoryGirl.create(:user)
    email = ActionMailer::Base.deliveries.last

    assert_equal "You have been invited to join Antiquarium", email.subject
    assert_equal [user.email], email.to
    assert_match /\/register\?token=#{user.activation_token}/, email.text_part.to_s
  end

  test "reactivating user should send reactivation email" do
    user = FactoryGirl.create(:user)
    user.activation_state = 'disabled'
    user.activation_token = nil
    user.name = "TEST"
    user.save

    user.reactivate_account!

    email = ActionMailer::Base.deliveries.last

    assert_equal "Your Antiquarium account has been reactivated", email.subject
    assert_equal [user.email], email.to
    assert_match /\/register\?token=#{user.activation_token}/, email.text_part.to_s
  end
end
