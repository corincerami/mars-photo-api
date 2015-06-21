class AddFullNameToCameras < ActiveRecord::Migration
  def change
    add_column :cameras, :full_name, :string
  end
end
