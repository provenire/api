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

FactoryGirl.define do
  factory :place do
    name        { Faker::Company.name }
    description { Faker::Lorem.paragraph }
  end
end
