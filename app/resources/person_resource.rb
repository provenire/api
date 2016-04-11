class PersonResource < JSONAPI::Resource
  include StandardResource

  attributes :gender, :date_of_birth, :date_of_death, :nationality


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
