class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.uuid :uuid, default: "uuid_generate_v4()"

      t.references :page,                      index: true
      t.references :tagged, polymorphic: true, index: true

      t.string :name,        default: '', null: false
      t.text   :description, default: ''

      t.json :location

      t.timestamps null: false
    end

    add_index :annotations, :uuid, unique: true
  end
end
