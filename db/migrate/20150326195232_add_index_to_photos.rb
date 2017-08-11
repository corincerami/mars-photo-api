class AddIndexToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_index :photos, :img_src
  end
end
