class AddZoomToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :zoom, :string
  end
end
