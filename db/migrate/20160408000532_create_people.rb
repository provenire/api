class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name,                              null: false
      t.text   :description,   default: ''
      t.string :gender,        default: 'unknown'
      t.date   :date_of_birth
      t.date   :date_of_death
      t.string :nationality,   default: 'unknown'

      t.timestamps null: false
    end
  end
end
