# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  uuid           :uuid
#  slug           :string           not null
#  name           :string           not null
#  description    :text             default("")
#  date           :date
#  status         :string
#  failed         :boolean          default("false"), not null
#  verb_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  price_cents    :integer          default("0"), not null
#  price_currency :string           default("USD"), not null
#
# Indexes
#
#  index_events_on_slug     (slug) UNIQUE
#  index_events_on_status   (status)
#  index_events_on_uuid     (uuid) UNIQUE
#  index_events_on_verb_id  (verb_id)
#

class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_name


  # Money
  monetize :price_cents, with_model_currency: :price_currency


  # Associations
  has_and_belongs_to_many :artifacts
  belongs_to :verb

  has_many :interactions
  has_many :people, through: :interactions, source: :actor, source_type: 'Person'
  has_many :places, through: :interactions, source: :actor, source_type: 'Place'

  has_many :citations, as: :entry
  has_many :sources, -> { uniq }, through: :citations


  # Callbacks
  before_save do |model|
    model.name = format_name
  end


  # Helpers
  def subjects
    interactions.where(recipient: false).includes(:actor).map(&:try_actor)
  end

  def recipients
    interactions.where(recipient: true).includes(:actor).map(&:try_actor)
  end


  private

  def format_date
    date ? date.year : 'Unknown Date'
  end

  def format_subject_names
    subjects.empty? ? 'unknown' : subjects.map(&:name).to_sentence
  end

  def format_recipient_names
    recipients.empty? ? 'unknown' : recipients.map(&:name).to_sentence
  end

  def format_name
    slug_name.first
  end

  def slug_name
    ["#{format_date} - #{verb.noun} by #{format_recipient_names}, via #{format_subject_names}",
     "#{format_date} - #{status} #{verb.noun} by #{format_recipient_names}, via #{format_subject_names}",
     "#{format_date} - #{failed} #{verb.noun} by #{format_recipient_names}, via #{format_subject_names}"]
  end
end
