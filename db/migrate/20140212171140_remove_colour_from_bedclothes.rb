class RemoveColourFromBedclothes < ActiveRecord::Migration
  def change
    remove_column :bedclothes, :colour, :string
  end
end
