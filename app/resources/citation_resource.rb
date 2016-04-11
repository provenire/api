class CitationResource < JSONAPI::Resource
  attributes :number, :content, :created_at, :updated_at


  # Attribute Modifiers
  def self.updatable_fields(context)
    super - [:created_at, :updated_at]
  end

  def self.creatable_fields(context)
    super - [:created_at, :updated_at]
  end


  # Associations
  has_one :source
  has_one :entry, polymorphic: true
end
