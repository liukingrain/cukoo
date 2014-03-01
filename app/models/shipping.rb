class Shipping
  attr_reader :items_amount_due, :address, :method
  
  def initialize(args = {})
    @items_amount_due = args[:items_amount_due]
    @address = args[:address]
    @method = args[:method]
  end

end
