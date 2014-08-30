class OrderItem < ActiveRecord::Base
  belongs_to :product, polymorphic: true
  belongs_to :order
  
  def amount_due
    product_price * quantity
  end
  
end
