# == Schema Information
#
# Table name: artifacts
#
#  id              :integer          not null, primary key
#  uuid            :uuid
#  slug            :string           not null
#  name            :string           not null
#  description     :text             default("")
#  alternate_names :string           default("{}"), not null, is an Array
#  artist          :string
#  dimensions      :string
#  date_created    :string
#  group           :boolean          default("false")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  picture_id      :integer
#
# Indexes
#
#  index_artifacts_on_alternate_names  (alternate_names)
#  index_artifacts_on_group            (group)
#  index_artifacts_on_slug             (slug) UNIQUE
#  index_artifacts_on_uuid             (uuid) UNIQUE
#

require 'test_helper'

class ArtifactTest < ActiveSupport::TestCase
  test "should not save if name not present" do
    artifact = FactoryGirl.build(:artifact, name: nil)
    assert_not artifact.save
  end
end
