class AddIndexOnEarthDate < ActiveRecord::Migration
  def change
    add_index(:photos, :earth_date)
  end
end
