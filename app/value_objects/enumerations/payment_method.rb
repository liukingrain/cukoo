class Enumerations::PaymentMethod < Enumerations::Base
  def self.options
    @options ||= %w(bank_transfer cash_on_delivery)
    #@options ||= %w(pay_u cash_on_delivery)
  end
  
  options.each do |option|
    define_method("#{option}?") do
      self == option
    end
  end
  
  private
  
  def translation_key
    "payment_method"
  end
end
