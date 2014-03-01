# -*- coding: utf-8 -*-
class Services::CreateOrderFromCartService
  attr_reader :cart
  
  def initialize(cart)
    @cart = cart
  end
  
  def call
    @success = ActiveRecord::Base.transaction do
      order.items = order_items     
      order.payment = payment
      order.save!
      cart.lock!
    end
    self
  end

  def success?
    !!@success
  end

  private
  
  def order
    @order ||= build_order
  end
  
  def build_order
    cart.build_order(order_attributes)
  end
  
  def order_attributes
    {
      user: cart.user,
      email: cart.email,
      shipping_address: cart.shipping_address.dup,
      billing_address: cart.billing_address.dup,
      shipping_method: cart.shipping_method,
      shipping_price: cart.shipping_price,
      payment_method: cart.payment_method,
      invoice: cart.invoice,
      custom_billing_address: cart.custom_billing_address,
      status: "new"
    }
  end
  
  def order_items
    cart.items.map do |cart_item|
      Services::BuildOrderItemFromCartItemService.new(cart_item).call.order_item
    end
  end
  
  def payment
    @payment ||= build_payment
  end
  
  def build_payment
    Services::BuildPaymentForOrderService.new(order).call.payment
  end
end
