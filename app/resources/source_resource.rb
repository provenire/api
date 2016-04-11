class SourceResource < JSONAPI::Resource
  include StandardResource

  attributes :authors, :date_created, :attribution, :identifier, :thumbnail, :document


  # Attribute Modifiers
  def self.updatable_fields(context)
    super - [:identifier, :thumbnail, :document]
  end

  def self.creatable_fields(context)
    super - [:identifier, :thumbnail, :document]
  end


  # Associations
  has_many :pages
  has_many :annotations
  has_many :citations
end
