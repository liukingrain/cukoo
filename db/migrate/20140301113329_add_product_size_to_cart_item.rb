class AddProductSizeToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :product_size, :string
  end
end
