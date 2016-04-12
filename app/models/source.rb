# == Schema Information
#
# Table name: sources
#
#  id           :integer          not null, primary key
#  uuid         :uuid
#  slug         :string           not null
#  kind         :string           default("document"), not null
#  name         :string           not null
#  description  :text             default("")
#  authors      :string           default("")
#  date_created :date
#  attribution  :string           default("")
#  identifier   :string
#  thumbnail    :string
#  document     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_sources_on_attribution  (attribution)
#  index_sources_on_authors      (authors)
#  index_sources_on_identifier   (identifier)
#  index_sources_on_kind         (kind)
#  index_sources_on_slug         (slug) UNIQUE
#  index_sources_on_uuid         (uuid) UNIQUE
#

class Source < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name


  # Uploaders
  mount_uploader :document, DocumentUploader
  mount_uploader :image,    ImageUploader


  # Associations
  has_many :pages, dependent: :destroy
  has_many :annotations, through: :pages
  has_many :citations


  # Validations
  validates :name, presence: true
  validates :kind, presence: true


  # Init Callbacks
  after_create :process_job


  # Revisions
  has_paper_trail only: [:kind,
                         :name,
                         :description,
                         :authors,
                         :date_created,
                         :attribution,
                         :identifier,
                         :image,
                         :document]


  private


  # Callback Functions
  def process_job
    "process_#{kind}_job".camelize.constantize.perform_later(self)
  end
end
