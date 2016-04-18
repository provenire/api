class PageResource < JSONAPI::Resource
  attributes :number, :text, :image, :created_at, :updated_at


  def image
    @model.image.versions.map{|k,v| [k, v.url] }.to_h
  end

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
