class AddIndexToPhotos < ActiveRecord::Migration
  def change
    add_index :photos, :img_src
  end
end
