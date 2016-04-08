class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.references :actor, polymorphic: true, index: true
      t.references :event,                    index: true

      t.boolean :recipient,     null: false, default: true
      t.boolean :unknown_actor, null: false, default: false

      t.timestamps null: false
    end

    add_index :interactions, :recipient
    add_index :interactions, :unknown_actor
  end
end
