class AddIndexOnSolToPhotos < ActiveRecord::Migration
  def change
    add_index :photos, :sol
  end
end
