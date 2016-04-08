class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name,                     null: false
      t.text   :description, default: ''
      
      t.timestamps null: false
    end
  end
end
