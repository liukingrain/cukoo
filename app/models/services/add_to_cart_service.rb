class Services::AddToCartService
  attr_reader :cart, :product_or_attributes
  
  def initialize(cart, product_or_attributes)
    @cart = cart
    @product_or_attributes = product_or_attributes
  end
  
  def call
    item.increment(:quantity) if duplicated_product?
    @success = item.save
    self
  end
  
  def success?
    !!@success
  end

  private
  
  def product
    @product ||= product_or_attributes.is_a?(Hash) ? product_from_hash(product_or_attributes) : product_or_attributes
  end
  
  def item
    @item ||= cart.items.for(product).first || build_item
  end
  
  def exists(size, id)
    cart.items.where(product_size: size, id: id).present?
  end
  
  def duplicated_product?
    item.persisted?
  end
  
  def build_item
    cart.items.build(product_id: product.id, product_type: product.class.to_s, product_size: product.size)
  end
  
  def product_from_hash(attributes)
    Struct.new(:id, :class, :size).new(attributes[:product_id], attributes[:product_type], attributes[:product_size])
  end
end
