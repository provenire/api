# == Schema Information
#
# Table name: annotations
#
#  id          :integer          not null, primary key
#  uuid        :uuid
#  page_id     :integer
#  tagged_id   :integer
#  tagged_type :string
#  name        :string           default(""), not null
#  description :text             default("")
#  location    :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_annotations_on_page_id                    (page_id)
#  index_annotations_on_tagged_type_and_tagged_id  (tagged_type,tagged_id)
#  index_annotations_on_uuid                       (uuid) UNIQUE
#

class Annotation < ActiveRecord::Base

  # Associations
  belongs_to :page
  has_one    :source, through: :page
  belongs_to :tagged, polymorphic: true


  # Validations
  validates :name, presence: true
end
