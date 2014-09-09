class CartItemDecorator < Draper::Decorator
  delegate_all
  
  def product_picture
    product.picture
  end
  
  def product_name
    product.name
  end
  
  private
  
  def product
    model.variant.product
  end
  
end
