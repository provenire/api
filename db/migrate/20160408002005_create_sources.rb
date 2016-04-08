class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :kind,         default: 'document', null: false
      t.string :name,                              null: false
      t.text   :description,  default: ''
      t.string :authors,      default: ''
      t.date   :date_created
      t.string :attribution,  default: ''

      # Files
      t.string :thumbnail
      t.string :document

      t.timestamps null: false
    end

    add_index :sources, :kind
    add_index :sources, :authors
    add_index :sources, :attribution
  end
end
