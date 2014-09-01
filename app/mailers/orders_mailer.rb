# encoding: utf-8
class OrdersMailer < ActionMailer::Base
  
  DEFAULT_FROM = "bok@cukoo.pl"
  DEFAULT_ORDERS_MAIL = "bok@cukoo.pl"
  
  default from: DEFAULT_FROM, charset: "UTF-8", "reply-to" => DEFAULT_ORDERS_MAIL

  def new_order(order)
    decorate_order(order)
    define_and_decorate_items(order)
    mail(to: @order.email, subject: "[Wydawnictwo Black] Zamówienie złożone")
  end

  def order_sent(order)
    decorate_order(order)
    define_and_decorate_items(order)
    mail(to: @order.email, subject: "[Wydawnictwo Black] Zamówienie wysłane")
  end
  
  def order_canceled(order)
    decorate_order(order)
    define_and_decorate_items(order)
    mail(to: @order.email, subject: "[Wydawnictwo Black] Zamówienie anulowane")
  end

  def order_paid(order)
    decorate_order(order)
    define_and_decorate_items(order)
    mail(to: @order.email, subject: "[Wydawnictwo Black] Płatność zakończona")
  end
  
  
  private
  
  def decorate_order(order)
    @order = order
  end
  
  def define_and_decorate_items(order)
    @items = OrderItemDecorator.decorate_collection(order.items)
  end
  
end

