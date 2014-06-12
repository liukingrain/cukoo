class RemoveProductTypeFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :product_type, :string
  end
end
