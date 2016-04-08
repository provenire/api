# == Schema Information
#
# Table name: sources
#
#  id           :integer          not null, primary key
#  kind         :string           default("document"), not null
#  name         :string           not null
#  description  :text             default("")
#  authors      :string           default("")
#  date_created :date
#  attribution  :string           default("")
#  thumbnail    :string
#  document     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_sources_on_attribution  (attribution)
#  index_sources_on_authors      (authors)
#  index_sources_on_kind         (kind)
#

class Source < ActiveRecord::Base

  # Validations
  validates :name, presence: true
  validates :kind, presence: true


  # Callbacks
  # after_create do |source|
  #   "process_#{kind}_job".camelize.constantize.perform_later(self)
  # end
end
