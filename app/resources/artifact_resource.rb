class ArtifactResource < JSONAPI::Resource
  include StandardResource

  attributes :alternate_names, :artist, :dimensions, :date_created, :group


  # Associations
  has_many :events
  has_many :annotations
  has_many :photos, class_name: 'Source'
  has_many :citations
  has_many :sources
  has_one  :picture, class_name: 'Source', foreign_key: 'picture'
end
