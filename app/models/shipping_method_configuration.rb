class ShippingMethodConfiguration
  extend ActiveModel::Naming
  include ActiveModel::Validations
  attr_reader :method_name
    
  def self.all
    Enumerations::ShippingMethod.options.map{ |method_name| self.new(method_name) }
  end
  
  def initialize(method_name)
    @method_name = method_name
  end
  
  def to_param
    method_name
  end
  
  def to_key
    [to_param]
  end
  
  def update_attributes(params = {})
    self.rates_attributes = params[:rates_attributes].values
    save!
  end
  
  def save!
    rates.each(&:save!) if rates.map(&:valid?).all?
  end
  
  def rates_attributes=(attributes)
    attributes.each do |rate_attributes|
      rates.find do |rate|
        rate.id.to_s == rate_attributes["id"]
      end.assign_attributes(rate_attributes)
    end
  end
  
  def persisted?
    true
  end
  
  def rates
    @rates ||= ShippingRate.where(shipping_method: method_name).all
  end
  
end
