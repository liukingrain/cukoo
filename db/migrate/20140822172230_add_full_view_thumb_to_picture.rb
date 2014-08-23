class AddFullViewThumbToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :full_view_thumb, :string
  end
end
