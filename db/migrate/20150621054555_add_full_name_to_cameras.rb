class AddFullNameToCameras < ActiveRecord::Migration[4.2]
  def change
    add_column :cameras, :full_name, :string
  end
end
