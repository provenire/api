class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.json     :object
      t.json     :object_changes
      t.string   :ip_address
      t.string   :user_agent
      t.string   :comment, default: ''

      t.datetime :created_at
    end
    add_index :versions, [:item_type, :item_id]
  end
end
