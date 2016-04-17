# == Schema Information
#
# Table name: people
#
#  id            :integer          not null, primary key
#  uuid          :uuid
#  slug          :string           not null
#  name          :string           not null
#  description   :text             default("")
#  gender        :string           default("unknown")
#  date_of_birth :date
#  date_of_death :date
#  nationality   :string           default("unknown")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  picture_id    :integer
#
# Indexes
#
#  index_people_on_slug  (slug) UNIQUE
#  index_people_on_uuid  (uuid) UNIQUE
#

class Person < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name


  # Associations
  has_many :affiliations
  has_many :interactions, as: :actor
  has_many :events, -> { uniq.order('date DESC NULLS LAST') }, through: :interactions
  has_many :annotations, as: :tagged

  has_many :annotated_pages,                     through: :annotations,     source: :page
  has_many :annotated_sources,                   through: :annotated_pages, source: :source

  has_many :photos, -> { where(kind: 'photo') }, through: :annotated_pages, source: :source
  belongs_to :picture, class_name: 'Source'

  # hack central
  has_many :source_events, -> { uniq }, through: :interactions,  source: :event
  has_many :citations,     -> { uniq }, through: :source_events
  has_many :sources,       -> { uniq }, through: :citations


  # Validations
  validates :name,        presence: true
  validates :gender,      presence: true
  validates :nationality, presence: true


  # Revisions
  has_paper_trail only: [:name,
                         :description,
                         :gender,
                         :date_of_birth,
                         :date_of_death,
                         :nationality]
end
