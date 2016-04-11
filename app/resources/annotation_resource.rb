class AnnotationResource < JSONAPI::Resource
  attributes :uuid, :name, :description, :location, :created_at, :updated_at


  # Attribute Modifiers
  def self.updatable_fields(context)
    super - [:uuid, :created_at, :updated_at]
  end

  def self.creatable_fields(context)
    super - [:uuid, :created_at, :updated_at]
  end


  # Associations
  has_one :page
  has_one :source
  has_one :tagged, polymorphic: true
end
