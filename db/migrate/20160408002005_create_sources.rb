class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.uuid   :uuid, default: "uuid_generate_v4()"
      t.string :slug, null: false

      t.string :kind,         default: 'document', null: false
      t.string :name,                              null: false
      t.text   :description,  default: ''
      t.string :authors,      default: ''
      t.date   :date_created
      t.string :attribution,  default: ''
      t.string :identifier

      # Files
      t.string :image
      t.string :document

      t.timestamps null: false
    end

    add_index :sources, :uuid, unique: true
    add_index :sources, :slug, unique: true
    add_index :sources, :kind
    add_index :sources, :authors
    add_index :sources, :attribution
    add_index :sources, :identifier
  end
end
