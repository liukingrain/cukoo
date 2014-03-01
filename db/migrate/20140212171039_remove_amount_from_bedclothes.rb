class RemoveAmountFromBedclothes < ActiveRecord::Migration
  def change
    remove_column :bedclothes, :amount, :integer
  end
end
