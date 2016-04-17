class AddPictureToResources < ActiveRecord::Migration
  def change
    add_column :artifacts, :picture_id, :integer
    add_column :people,    :picture_id, :integer
    add_column :places,    :picture_id, :integer
  end
end
