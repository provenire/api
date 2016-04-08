# == Schema Information
#
# Table name: annotations
#
#  id          :integer          not null, primary key
#  uuid        :uuid
#  page_id     :integer
#  tagged_id   :integer
#  tagged_type :string
#  name        :string           default(""), not null
#  description :text             default("")
#  location    :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_annotations_on_page_id                    (page_id)
#  index_annotations_on_tagged_type_and_tagged_id  (tagged_type,tagged_id)
#  index_annotations_on_uuid                       (uuid) UNIQUE
#

FactoryGirl.define do
  factory :annotation do
    page
    association :tagged, factory: [:artifact, :person, :place].sample
    uuid        { SecureRandom.uuid }
    name        { Faker::Hipster.sentence }
    description { Faker::Hipster.paragraph }
  end
end
