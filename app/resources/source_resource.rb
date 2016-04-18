class SourceResource < JSONAPI::Resource
  include StandardResource

  attributes :kind, :authors, :date_created, :attribution, :identifier, :image, :document

  def image
    @model.image.versions.map{|k,v| [k, v.url] }.to_h
  end

  def document
    @model.document.url
  end


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
