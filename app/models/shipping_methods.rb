module ShippingMethods
  def self.factory(method_name)
    "ShippingMethods::#{method_name.classify}".constantize
  end

  def shipping_discount
    active_bargains.inject(0){ |sum, bargain| sum + bargain.shipping_discount_value(self) }
  end

end
