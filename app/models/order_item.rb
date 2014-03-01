class OrderItem < ActiveRecord::Base
  belongs_to :product, polymorphic: true
  belongs_to :order
  
  
end
