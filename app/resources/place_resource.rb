class PlaceResource < JSONAPI::Resource
  include StandardResource
  

  # Associations
  has_many :affiliations
  has_many :interactions
  has_many :events
  has_many :annotations
  has_many :photos, class_name: 'Source'
  has_many :citations
  has_many :sources
  has_one  :picture, class_name: 'Source', foreign_key: 'picture'
end
