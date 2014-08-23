class AddPatternThumbToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :pattern_thumb, :string
  end
end
