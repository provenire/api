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

class Artifact < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name


  # Associations
  has_and_belongs_to_many :events, -> { order('date DESC NULLS LAST') }
  has_many :annotations, as: :tagged

  has_many :annotated_pages,                     through: :annotations,     source: :page
  has_many :annotated_sources,                   through: :annotated_pages, source: :source

  has_many :photos, -> { where(kind: 'photo') }, through: :annotated_pages, source: :source
  belongs_to :picture, class_name: 'Source'

  # hack central
  has_many :citations, through: :events
  has_many :sources,   through: :citations


  # Validations
  validates :name, presence: true


  # Revisions
  has_paper_trail class_name: 'Version',
                  only: [:name,
                         :description,
                         :alternate_names,
                         :artist,
                         :dimensions,
                         :date_created,
                         :group]
end
