# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  source_id  :integer
#  number     :integer
#  text       :text
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pages_on_number                (number)
#  index_pages_on_source_id             (source_id)
#  index_pages_on_source_id_and_number  (source_id,number) UNIQUE
#

class Page < ActiveRecord::Base
  # Uploaders
  mount_uploader :image, PageImageUploader

  # Associations
  belongs_to :source
  has_many   :annotations, dependent: :destroy

  # Validations
  validates :number, presence: true
end
