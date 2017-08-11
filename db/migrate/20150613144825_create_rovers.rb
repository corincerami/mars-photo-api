class CreateRovers < ActiveRecord::Migration[4.2]
  def change
    create_table :rovers do |t|
      t.string :name
      t.date :landing_date
    end
  end
end
