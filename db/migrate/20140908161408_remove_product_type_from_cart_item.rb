class RemoveProductTypeFromCartItem < ActiveRecord::Migration
  def change
    remove_column :cart_items, :product_type, :string
  end
end
