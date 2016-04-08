# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  uuid           :uuid
#  slug           :string           not null
#  name           :string           not null
#  description    :text             default("")
#  date           :date
#  status         :string
#  failed         :boolean          default("false"), not null
#  verb_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  price_cents    :integer          default("0"), not null
#  price_currency :string           default("USD"), not null
#
# Indexes
#
#  index_events_on_slug     (slug) UNIQUE
#  index_events_on_status   (status)
#  index_events_on_uuid     (uuid) UNIQUE
#  index_events_on_verb_id  (verb_id)
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "should correctly format name" do
    event = FactoryGirl.create(:event)

    subject = FactoryGirl.create(:person)
    recipient = FactoryGirl.create(:place)

    subject_interaction = FactoryGirl.create(:interaction, event: event, actor: subject, unknown_actor: false, recipient: false)
    recipient_interaction = FactoryGirl.create(:interaction, event: event, actor: recipient, unknown_actor: false, recipient: true)

    event.price = 10
    event.save

    assert_equal "#{event.date.year} - #{event.verb.noun} by #{event.recipients.map(&:name).to_sentence}, via #{event.subjects.map(&:name).to_sentence}", event.name
  end
end
