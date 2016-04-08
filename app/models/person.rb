# == Schema Information
#
# Table name: people
#
#  id            :integer          not null, primary key
#  uuid          :uuid
#  slug          :string           not null
#  name          :string           not null
#  description   :text             default("")
#  gender        :string           default("unknown")
#  date_of_birth :date
#  date_of_death :date
#  nationality   :string           default("unknown")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_people_on_slug  (slug) UNIQUE
#  index_people_on_uuid  (uuid) UNIQUE
#

class Person < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name


  # Associations
  has_many :affiliations


  # Validations
  validates :name,        presence: true
  validates :gender,      presence: true
  validates :nationality, presence: true

end
