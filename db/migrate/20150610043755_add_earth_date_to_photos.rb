class AddEarthDateToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :earth_date, :datetime
  end
end
