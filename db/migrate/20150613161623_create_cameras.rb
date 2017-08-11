class CreateCameras < ActiveRecord::Migration[4.2]
  def change
    create_table :cameras do |t|
      t.string :name
      t.integer :rover_id
    end
  end
end
