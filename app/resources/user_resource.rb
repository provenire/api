class UserResource < JSONAPI::Resource
  include StandardResource

  attributes :email, :company, :location, :role, :password, :password_confirmation


  # Attribute Modifiers
  # def self.fields
  #   super - [:password, :password_confirmation]
  # end

  def self.updatable_fields(context)
    super - [:role]
  end

  def self.creatable_fields(context)
    super - [:role]
  end

  def password
    nil
  end

  def password_confirmation
    nil
  end
end
