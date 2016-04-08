# == Schema Information
#
# Table name: verbs
#
#  id              :integer          not null, primary key
#  keyword         :string           not null
#  action          :string           not null
#  noun            :string           not null
#  components      :string           default("{date,status,description}"), not null, is an Array
#  subject_types   :string           default("{people,places}"), not null, is an Array
#  recipient_types :string           default("{people,places}"), not null, is an Array
#  subject_limit   :integer
#  recipient_limit :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_verbs_on_action   (action) UNIQUE
#  index_verbs_on_keyword  (keyword) UNIQUE
#  index_verbs_on_noun     (noun) UNIQUE
#

class Verb < ActiveRecord::Base

  # Associations
  has_many :events


  # Validations
  validates :keyword,    presence: true
  validates :action,     presence: true
  validates :noun,       presence: true
  validates :components, presence: true


  # Helpers
  def name
    keyword.humanize
  end

  def description
    components.to_sentence
  end
end
