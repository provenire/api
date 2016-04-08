class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.uuid   :uuid, default: "uuid_generate_v4()"
      t.string :slug, null: false

      t.string  :name,                        null: false
      t.text    :description, default: ''
      t.date    :date
      t.string  :status
      t.boolean :failed,      default: false, null: false

      t.references :verb, index: true

      t.timestamps null: false
    end

    add_monetize :events, :price

    add_index :events, :uuid, unique: true
    add_index :events, :slug, unique: true
    add_index :events, :status
  end
end
