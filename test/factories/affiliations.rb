# == Schema Information
#
# Table name: affiliations
#
#  id          :integer          not null, primary key
#  uuid        :uuid
#  slug        :string           not null
#  name        :string           not null
#  description :text             default("")
#  person_id   :integer
#  place_id    :integer
#  title       :string
#  start_date  :date
#  end_date    :date
#  current     :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_affiliations_on_person_id  (person_id)
#  index_affiliations_on_place_id   (place_id)
#  index_affiliations_on_slug       (slug) UNIQUE
#  index_affiliations_on_uuid       (uuid) UNIQUE
#

FactoryGirl.define do
  factory :affiliation do
    person
    place
    uuid        { SecureRandom.uuid }
    name        { "#{Faker::Name.name} with #{Faker::Company.name}" }
    description { Faker::Lorem.paragraph }
    title       { Faker::Company.profession }
    start_date  { Faker::Date.between(60.years.ago, Date.today) }
    end_date    { Faker::Date.between(60.years.ago, Date.today) }
    current     { Faker::Boolean.boolean }
  end
end
