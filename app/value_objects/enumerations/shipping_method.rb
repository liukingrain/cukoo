class Enumerations::ShippingMethod < Enumerations::Base
  def self.options
    #@options ||= %w(courier post personal_receipt)
    @options ||= %w(post personal_receipt)
  end
  
  def options
    super.select do |method|
      ShippingMethods.factory(method).available_for?(model.shipping)
    end
  end
  
  def calculate_price
    calculator_class.new(model.shipping).calculate
  end
  
  private
  
  def calculator_class
    "ShippingMethods::#{value.try(:classify) || "Base"}::PriceCalculator".constantize
  end
end
