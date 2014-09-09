class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :variant, polymorphic: true
    
  before_validation :set_default_values
  
  scope :for, lambda { |variant| where(variant_id: variant.id, variant_type: variant.class.to_s) }
  
  def product_price
    variant.price
  end
  
  def variant_name
    variant.name
  end    
  
  def amount_due
    product_price * quantity
  end
  
  private
  
  def set_default_values
    self.quantity ||= 1
  end
  
  
  
  
end
