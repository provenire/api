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

FactoryGirl.define do
  factory :person do
    uuid          { SecureRandom.uuid }
    name          { Faker::Name.name }
    description   { Faker::Lorem.paragraph }
    gender        { ['male', 'female', 'unknown'].sample }
    date_of_birth { [nil, Faker::Date.between(100.years.ago, Date.today)].sample }
    date_of_death { [nil, Faker::Date.between(100.years.ago, Date.today)].sample }
    nationality   { Faker::Address.country }
  end
end
