class AddLaunchDateAndStatusToRover < ActiveRecord::Migration
  def change
    add_column :rovers, :launch_date, :date
    add_column :rovers, :status, :string
  end
end
