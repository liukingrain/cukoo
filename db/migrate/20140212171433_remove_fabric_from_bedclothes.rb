class RemoveFabricFromBedclothes < ActiveRecord::Migration
  def change
    remove_column :bedclothes, :fabric, :string
  end
end
