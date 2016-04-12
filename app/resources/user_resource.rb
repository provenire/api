class UserResource < JSONAPI::Resource
  include StandardResource

  attributes :email, :company, :location, :role


  # Attribute Modifiers
  def self.updatable_fields(context)
    super - [:role]
  end

  def self.creatable_fields(context)
    super - [:role]
  end
end
