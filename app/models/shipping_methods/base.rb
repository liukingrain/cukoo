class ShippingMethods::Base
  class PriceCalculator
    SHIPPING_RATE = 13.5
    
    attr_reader :shipping
    
    def initialize(shipping)
      @shipping = shipping
    end
    
    def calculate
      # if shipping.rate.present?
      #   if shipping.items_amount_due >= shipping.rate.free_of_charge_treshold
      #     0
      #   else
      #     shipping.rate.rate
      #   end
      # else
      #   raise NotImplementedError
      # end
      
      SHIPPING_RATE
    end
  end
  
  def self.available_for?(shipping)
    true
  end

end
