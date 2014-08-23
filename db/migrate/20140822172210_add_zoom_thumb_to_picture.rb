class AddZoomThumbToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :zoom_thumb, :string
  end
end
