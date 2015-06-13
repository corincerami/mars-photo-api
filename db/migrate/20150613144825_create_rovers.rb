class CreateRovers < ActiveRecord::Migration
  def change
    create_table :rovers do |t|
      t.string :name
      t.date :landing_date
    end
  end
end
