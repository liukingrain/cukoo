class CartItemDecorator < Draper::Decorator
  delegate_all
  
  def product_picture
    product.picture.full_view_thumb.url
  end
  
  def product_name
    product.name
  end
  
  def product_size
    model.variant.size    
  end
  
  private
  
  def product
    model.variant.product
  end
  
end
