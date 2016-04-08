class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.references :source,                    index: true
      t.references :entry,  polymorphic: true, index: true

      t.integer :number
      t.string  :content, null: false, default: ''
      
      t.timestamps null: false
    end
  end
end
