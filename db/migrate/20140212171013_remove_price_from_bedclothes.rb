class RemovePriceFromBedclothes < ActiveRecord::Migration
  def change
    remove_column :bedclothes, :price, :float
  end
end
