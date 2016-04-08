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

require 'test_helper'

class CitationTest < ActiveSupport::TestCase
  test "should not save if source, entry not present" do
    citation = FactoryGirl.build(:citation, source: nil)
    assert_not citation.save

    citation = FactoryGirl.build(:citation, entry: nil)
    assert_not citation.save
  end
end
