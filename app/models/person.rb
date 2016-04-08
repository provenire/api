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

class Person < ActiveRecord::Base

  # Validations
  validates :name,        presence: true
  validates :gender,      presence: true
  validates :nationality, presence: true
  
end
