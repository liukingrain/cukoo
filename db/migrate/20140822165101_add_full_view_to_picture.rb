class AddFullViewToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :full_view, :string
  end
end
