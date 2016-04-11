class PageResource < JSONAPI::Resource
  attributes :number, :text, :image, :created_at, :updated_at


  # Attribute Modifiers
  def self.updatable_fields(context)
    super - [:number, :text, :image, :created_at, :updated_at]
  end

  def self.creatable_fields(context)
    super - [:number, :text, :image, :created_at, :updated_at]
  end


  # Associations
  has_one :source
  has_many :annotations
end
