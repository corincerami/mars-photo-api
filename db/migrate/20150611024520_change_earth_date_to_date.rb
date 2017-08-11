class ChangeEarthDateToDate < ActiveRecord::Migration[4.2]
  def change
    remove_column :photos, :earth_date, :datetime
    add_column :photos, :earth_date, :date
  end
end
