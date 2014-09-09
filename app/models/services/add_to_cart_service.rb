class Services::AddToCartService
  attr_reader :cart, :variant_or_attributes
  
  def initialize(cart, variant_or_attributes)
    @cart = cart
    @variant_or_attributes = variant_or_attributes
  end
  
  def call
    item.increment(:quantity) if duplicated_variant?
    @success = item.save
    self
  end
  
  def success?
    !!@success
  end

  private
  
  def variant
    @variant ||= variant_or_attributes.is_a?(Hash) ? variant_from_hash(variant_or_attributes) : variant_or_attributes
  end
  
  def item
    @item ||= cart.items.for(variant).first || build_item
  end
  
  def duplicated_variant?
    item.persisted?
  end
  
  def build_item
    cart.items.build(variant_id: variant.id, variant_type: variant.type)
  end
  
  def variant_from_hash(attributes)
    Struct.new(:id, :type).new(attributes[:variant_id], attributes[:variant_type])
  end
end
