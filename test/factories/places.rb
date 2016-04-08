# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             default("")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :place do
    name        { Faker::Company.name }
    description { Faker::Lorem.paragraph }
  end
end
