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

end
