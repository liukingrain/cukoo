class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product, polymorphic: true
    
  before_validation :set_default_values
  
  scope :for, lambda { |product| where(product_id: product.id, product_type: product.class, product_size: product.size) }
  
  def product_price
    variant.price
  end
  
  def product_name
    product.name
  end
  
  def product_picture
    product.picture
  end
    
  
  def amount_due
    product_price * quantity
  end
  
  def product
    Product.find(product_id)
  end
  
  def variant
    product.variants.find_by_size(product_size)
  end
  
  private
  
  def set_default_values
    self.quantity ||= 1
  end
  
  
  
  
end
