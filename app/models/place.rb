# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  uuid        :uuid
#  slug        :string           not null
#  name        :string           not null
#  description :text             default("")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_places_on_slug  (slug) UNIQUE
#  index_places_on_uuid  (uuid) UNIQUE
#

class Place < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name
  

  # Validations
  validates :name, presence: true

end
