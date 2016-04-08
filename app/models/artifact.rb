# == Schema Information
#
# Table name: artifacts
#
#  id              :integer          not null, primary key
#  uuid            :uuid
#  slug            :string           not null
#  name            :string           not null
#  description     :text             default("")
#  alternate_names :string           default("{}"), not null, is an Array
#  artist          :string
#  dimensions      :string
#  date_created    :string
#  group           :boolean          default("false")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_artifacts_on_alternate_names  (alternate_names)
#  index_artifacts_on_group            (group)
#  index_artifacts_on_slug             (slug) UNIQUE
#  index_artifacts_on_uuid             (uuid) UNIQUE
#

class Artifact < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name
  

  # Associations
  # ...

  # Validations
  validates :name, presence: true
end
