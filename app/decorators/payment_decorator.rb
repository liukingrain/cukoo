class PaymentDecorator < Draper::Decorator
  
  decorates :payment
  delegate_all
  
end
