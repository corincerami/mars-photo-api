class AddIndexOnEarthDate < ActiveRecord::Migration[4.2]
  def change
    add_index(:photos, :earth_date)
  end
end
