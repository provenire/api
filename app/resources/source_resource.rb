class SourceResource < JSONAPI::Resource
  include StandardResource

  attributes :authors, :date_created, :attribution, :identifier, :image, :document


  # Attribute Modifiers
  def self.updatable_fields(context)
    super - [:identifier, :image, :document]
  end

  def self.creatable_fields(context)
    super - [:identifier, :image, :document]
  end


  # Associations
  has_many :pages
  has_many :annotations
  has_many :citations
end
