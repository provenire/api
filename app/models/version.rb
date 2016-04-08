# == Schema Information
#
# Table name: versions
#
#  id             :integer          not null, primary key
#  item_type      :string           not null
#  item_id        :integer          not null
#  event          :string           not null
#  whodunnit      :string
#  object         :json
#  object_changes :json
#  ip_address     :string
#  user_agent     :string
#  comment        :string           default("")
#  created_at     :datetime
#  transaction_id :integer
#
# Indexes
#
#  index_versions_on_item_type_and_item_id  (item_type,item_id)
#  index_versions_on_transaction_id         (transaction_id)
#

class Version < PaperTrail::Version
  self.table_name = :versions


  # Discussions
  # acts_as_messageable
end
