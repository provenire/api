class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :keyword, null: false
      t.string :action,  null: false
      t.string :noun,    null: false

      t.string :components,      null: false, array: true, default: ["date", "status", "description"]
      t.string :subject_types,   null: false, array: true, default: ["people", "places"]
      t.string :recipient_types, null: false, array: true, default: ["people", "places"]

      t.integer :subject_limit
      t.integer :recipient_limit

      t.timestamps null: false
    end

    add_index :verbs, :action,  unique: true
    add_index :verbs, :keyword, unique: true
    add_index :verbs, :noun,    unique: true
  end
end
