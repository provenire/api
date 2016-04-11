# == Schema Information
#
# Table name: citations
#
#  id         :integer          not null, primary key
#  source_id  :integer
#  entry_id   :integer
#  entry_type :string
#  number     :integer
#  content    :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_citations_on_entry_type_and_entry_id  (entry_type,entry_id)
#  index_citations_on_source_id                (source_id)
#

FactoryGirl.define do
  factory :citation do
    source
    association :entry, factory: [:artifact, :person, :place, :event].sample
    number  { Faker::Number.between(1, 10) }
    content { Faker::Lorem.sentence }
  end
end
