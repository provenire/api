class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt

      # Custom
      t.string :slug, null: false
      t.uuid   :uuid, default: "uuid_generate_v4()"

      t.string :name
      t.string :description
      t.string :company
      t.string :location
      t.string :role, default: 'user'

      t.integer :login_count, default: 0, null: false
      
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :uuid,  unique: true
    add_index :users, :slug,  unique: true
  end
end
