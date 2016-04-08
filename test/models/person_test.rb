# == Schema Information
#
# Table name: people
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  description   :text             default("")
#  gender        :string           default("unknown")
#  date_of_birth :date
#  date_of_death :date
#  nationality   :string           default("unknown")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "should not save if name, gender, nationality not present" do
    person = FactoryGirl.build(:person, name: nil)
    assert_not person.save

    person = FactoryGirl.build(:person, gender: nil)
    assert_not person.save

    person = FactoryGirl.build(:person, nationality: nil)
    assert_not person.save
  end
end
