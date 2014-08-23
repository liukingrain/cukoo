class AddPatternToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :pattern, :string
  end
end
