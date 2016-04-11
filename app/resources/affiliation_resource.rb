class AffiliationResource < JSONAPI::Resource
  include StandardResource

  attributes :title, :start_date, :end_date, :current


  # Associations
  has_one :person
  has_one :place
end
