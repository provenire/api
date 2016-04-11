class EventResource < JSONAPI::Resource
  include StandardResource

  attributes :date, :status, :failed, :price


  # Associations
  has_many :artifacts
  has_one  :verb
  has_many :interactions
  has_many :people
  has_many :places
  has_many :citations
  has_many :sources
end
