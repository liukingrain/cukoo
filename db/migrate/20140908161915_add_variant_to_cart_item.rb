class AddVariantToCartItem < ActiveRecord::Migration
  def change
    add_reference :cart_items, :variant, polymorphic: true, index: true
  end
end
