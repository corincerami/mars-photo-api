class RemoveNullFalseFromPhotos < ActiveRecord::Migration
  def up
    change_column :photos, :camera, :string, null: true
  end

  def down
    change_column :photos, :camera, :string, null: false
  end
end
