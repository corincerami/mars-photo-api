class AddIndexOnSolToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_index :photos, :sol
  end
end
