# == Schema Information
#
# Table name: sources
#
#  id           :integer          not null, primary key
#  kind         :string           default("document"), not null
#  name         :string           not null
#  description  :text             default("")
#  authors      :string           default("")
#  date_created :date
#  attribution  :string           default("")
#  thumbnail    :string
#  document     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_sources_on_attribution  (attribution)
#  index_sources_on_authors      (authors)
#  index_sources_on_kind         (kind)
#

FactoryGirl.define do
  factory :source do
    name         { Faker::Company.catch_phrase }
    description  { Faker::Lorem.paragraph }
    authors      { Faker::Name.name }
    date_created { Faker::Date.between(100.years.ago, Date.today) }
    attribution  { [nil, "Nytimes (www.nytimes.com)"].sample }
  end
end
