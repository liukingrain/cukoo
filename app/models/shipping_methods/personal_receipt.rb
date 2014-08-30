class ShippingMethods::PersonalReceipt < ShippingMethods::Base
  class PriceCalculator < ShippingMethods::Base::PriceCalculator
    def calculate
      0
    end
  end
  
end
