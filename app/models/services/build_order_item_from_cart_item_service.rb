# -*- coding: utf-8 -*-
class Services::BuildOrderItemFromCartItemService
  attr_reader :cart_item, :order_item
  
  def initialize(cart_item)
    @cart_item = cart_item
  end
  
  def call
    new_order_item
    self
  end

  private
    
  def new_order_item
    @order_item = OrderItem.new(order_item_attributes)
  end
  
  def product
    @product ||= cart_item.product
  end
  
  def order_item_attributes
    {
      product_type: cart_item.product_type,
      product_id: cart_item.product_id,
      quantity: cart_item.quantity,
      product_name: product_name,
      product_price: product.price,
      product_size: product.size
    }
  end
  
  def product_name
    product.name
  end
end
