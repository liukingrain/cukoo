# -*- coding: utf-8 -*-
class Services::BuildPaymentForOrderService
  attr_reader :order
    
  def initialize(order)
    # freezowanie liczb w rubym 2.0
    @order = order.dup
  end
  
  def call
    build_with_status
    self
  end
  
  def redirect_url
    payment.url
  end

  def payment
    @payment ||= build_payment
  end
  
  def status    
    @status ||= payment.statuses.build
  end
  
  private
  
  def build_payment
    order.build_payment(payment_attributes)
  end
  
  def payment_attributes
    {
      amount: order.amount_due,
      method: order.payment_method
    }
  end
  
  def build_with_status
    status.status = order.payment_method.cash_on_delivery? ? "n/a" : "uninitiated"
  end
  
end
