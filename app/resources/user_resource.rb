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


  # Callbacks
  before_update do |user, context|
    user.id == context[:current_user].id
  end
end
