class VerbResource < JSONAPI::Resource
  immutable
  
  attributes :keyword, :action, :noun, :components, :subject_types, :recipient_types,
             :subject_limit, :recipient_limit


  # Associations
  has_many :events
end
