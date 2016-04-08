class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.string :name, null: false
      t.text   :description, default: ''

      t.string :alternate_names, array: true, null: false, default: []
      t.string :artist
      t.string :dimensions
      t.string :date_created

      t.boolean :group, default: false

      t.timestamps null: false
    end

    add_index :artifacts, :alternate_names
    add_index :artifacts, :group
  end
end
