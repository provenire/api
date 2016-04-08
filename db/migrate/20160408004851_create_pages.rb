class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :source, index: true
      t.integer    :number, index: true

      t.text       :text
      t.string     :image

      t.timestamps null: false
    end

    add_index :pages, [:source_id, :number], unique: true
  end
end
