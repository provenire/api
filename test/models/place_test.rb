# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             default("")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  test "should not save if name not present" do
    place = FactoryGirl.build(:place, name: nil)
    assert_not place.save
  end
end
