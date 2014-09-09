class RemoveProductSizeFromCartItem < ActiveRecord::Migration
  def change
    remove_column :cart_items, :product_size, :string
  end
end
