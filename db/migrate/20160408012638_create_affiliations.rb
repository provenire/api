class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.uuid   :uuid, default: "uuid_generate_v4()"
      t.string :slug, null: false

      t.string :name,                     null: false
      t.text   :description, default: ''

      t.references :person, index: true
      t.references :place,  index: true

      t.string  :title
      t.date    :start_date
      t.date    :end_date
      t.boolean :current, default: false

      t.timestamps null: false
    end

    add_index :affiliations, :uuid, unique: true
    add_index :affiliations, :slug, unique: true
  end
end
