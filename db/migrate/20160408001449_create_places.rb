class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.uuid   :uuid, default: "uuid_generate_v4()"
      t.string :slug, null: false

      t.string :name,                     null: false
      t.text   :description, default: ''

      t.timestamps null: false
    end

    add_index :places, :uuid, unique: true
    add_index :places, :slug, unique: true
  end
end
