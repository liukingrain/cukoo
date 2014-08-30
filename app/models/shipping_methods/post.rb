class ShippingMethods::Post < ShippingMethods::Base
  class PriceCalculator < ShippingMethods::Base::PriceCalculator
    def calculate
      if shipping.items_amount_due > shipping.free_of_charge_threshold
        0
      else
        SHIPPING_RATE
      end
    end
  end
  
end
