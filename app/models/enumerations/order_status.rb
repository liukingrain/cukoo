class Enumerations::OrderStatus < Enumerations::Base
  def self.options
    @options ||= %w(new ready sent canceled)
  end
  
  private
  
  def translation_key
    "order_status"
  end
end
