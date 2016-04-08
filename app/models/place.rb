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

class Place < ActiveRecord::Base

  # Validations
  validates :name, presence: true
  
end
