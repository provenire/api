# == Schema Information
#
# Table name: affiliations
#
#  id          :integer          not null, primary key
#  uuid        :uuid
#  slug        :string           not null
#  name        :string           not null
#  description :text             default("")
#  person_id   :integer
#  place_id    :integer
#  title       :string
#  start_date  :date
#  end_date    :date
#  current     :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_affiliations_on_person_id  (person_id)
#  index_affiliations_on_place_id   (place_id)
#  index_affiliations_on_slug       (slug) UNIQUE
#  index_affiliations_on_uuid       (uuid) UNIQUE
#

require 'test_helper'

class AffiliationTest < ActiveSupport::TestCase
  test "should format name properly" do
    affiliation = FactoryGirl.create(:affiliation, end_date: Date.today, current: false)
    assert_equal "#{affiliation.person.name} with #{affiliation.place.name}, #{affiliation.start_date.year} - #{affiliation.end_date.year}", affiliation.name

    affiliation = FactoryGirl.create(:affiliation, current: true)
    assert_equal "#{affiliation.person.name} with #{affiliation.place.name}, #{affiliation.start_date.year} - Present", affiliation.name

    affiliation = FactoryGirl.create(:affiliation, current: false, end_date: nil)
    assert_equal "#{affiliation.person.name} with #{affiliation.place.name}, #{affiliation.start_date.year}", affiliation.name

    affiliation = FactoryGirl.create(:affiliation, current: false, start_date: nil)
    assert_equal "#{affiliation.person.name} with #{affiliation.place.name}, Unknown - #{affiliation.end_date.year}", affiliation.name

    affiliation = FactoryGirl.create(:affiliation, current: false, start_date: nil, end_date: nil)
    assert_equal "#{affiliation.person.name} with #{affiliation.place.name}", affiliation.name
  end
end
