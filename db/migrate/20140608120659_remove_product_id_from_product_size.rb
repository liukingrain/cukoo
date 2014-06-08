class RemoveProductIdFromProductSize < ActiveRecord::Migration
  def change
    remove_column :product_sizes, :product_id, :integer
  end
end
