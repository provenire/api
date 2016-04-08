# == Schema Information
#
# Table name: interactions
#
#  id            :integer          not null, primary key
#  actor_id      :integer
#  actor_type    :string
#  event_id      :integer
#  recipient     :boolean          default("true"), not null
#  unknown_actor :boolean          default("false"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_interactions_on_actor_type_and_actor_id  (actor_type,actor_id)
#  index_interactions_on_event_id                 (event_id)
#  index_interactions_on_recipient                (recipient)
#  index_interactions_on_unknown_actor            (unknown_actor)
#

FactoryGirl.define do
  factory :interaction do
    association :actor, factory: [:person, :place].sample
    event

    recipient     { Faker::Boolean.boolean }
    unknown_actor { Faker::Boolean.boolean }
  end
end
