class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :photos do |t|
      t.string :img_src, null: false
      t.integer :sol, null: false
      t.string :camera, null: false
    end
  end
end
