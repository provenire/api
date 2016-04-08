# == Schema Information
#
# Table name: sources
#
#  id           :integer          not null, primary key
#  uuid         :uuid
#  slug         :string           not null
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
#  index_sources_on_slug         (slug) UNIQUE
#  index_sources_on_uuid         (uuid) UNIQUE
#

require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  test "should not save if name, kind not present" do
    source = FactoryGirl.build(:source, name: nil)
    assert_not source.save

    source = FactoryGirl.build(:source, kind: nil)
    assert_not source.save
  end
end
