class InteractionResource < JSONAPI::Resource
  attributes :recipient, :unknown_actor, :created_at, :updated_at


  # Attribute Modifiers
  def self.updatable_fields(context)
    super - [:created_at, :updated_at]
  end

  def self.creatable_fields(context)
    super - [:created_at, :updated_at]
  end


  # Associations
  has_one :event
  has_one :actor, polymorphic: true
end
