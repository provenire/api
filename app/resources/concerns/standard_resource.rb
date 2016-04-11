module StandardResource
  extend ActiveSupport::Concern

  included do
    attributes  :name, :description, :uuid, :slug, :created_at, :updated_at
  end

  class_methods do
    # Attribute Modifiers
    def updatable_fields(context)
      super - [:uuid, :slug, :created_at, :updated_at]
    end

    def creatable_fields(context)
      super - [:uuid, :slug, :created_at, :updated_at]
    end
  end
end
