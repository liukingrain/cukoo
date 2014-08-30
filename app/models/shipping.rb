class Shipping
  FREE_OF_CHARGE_THRESHOLD = 200
  attr_reader :items_amount_due, :address, :method
  
  def initialize(args = {})
    @items_amount_due = args[:items_amount_due]
    @address = args[:address]
    @method = args[:method]
  end
  
  def free_of_charge_threshold
    FREE_OF_CHARGE_THRESHOLD
  end

end
