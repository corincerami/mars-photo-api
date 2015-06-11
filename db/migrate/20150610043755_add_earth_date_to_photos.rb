class AddEarthDateToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :earth_date, :datetime
  end
end
