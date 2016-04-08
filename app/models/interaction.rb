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

class Interaction < ActiveRecord::Base

  # Associations
  belongs_to :actor, polymorphic: true
  belongs_to :event


  # Validations
  validates :recipient,     presence: true
  validates :unknown_actor, presence: true


  # Helpers
  def try_actor
    unknown_actor ? OpenStruct.new(name: 'unknown') : actor
  end
end
