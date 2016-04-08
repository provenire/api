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

require 'test_helper'

class InteractionTest < ActiveSupport::TestCase
  test "should not save if recipient, unknown_actor not present" do
    interaction = FactoryGirl.build(:interaction, recipient: nil)
    assert_not interaction.save

    interaction = FactoryGirl.build(:interaction, unknown_actor: nil)
    assert_not interaction.save
  end

  test "#try_actor should always return object" do
    interaction = FactoryGirl.create(:interaction, unknown_actor: true, actor: nil)
    assert_equal 'unknown', interaction.try_actor.name

    actor = FactoryGirl.create(:place)
    interaction = FactoryGirl.create(:interaction, unknown_actor: false, actor: actor)
    assert_equal actor.name, interaction.try_actor.name
  end
end
