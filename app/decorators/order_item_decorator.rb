class OrderItemDecorator < Draper::Decorator
  delegate_all
  decorate :item
  
end