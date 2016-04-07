class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt

      # Custom
      t.string :name
      t.string :description
      t.string :company
      t.string :location
      t.string :role, default: 'user'

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
