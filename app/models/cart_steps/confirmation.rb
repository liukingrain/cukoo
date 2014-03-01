class CartSteps::Confirmation < CartSteps::Base
  
  delegate :items, :amount_due, :order, :shipping_method, :items_amount_due,
           :shipping_price, :shipping_address, :billing_address, :invoice,
           :custom_billing_address, :comment, to: :cart
  validates :terms, acceptance: true, allow_nil: false
  
  def save
    if super && create_order_from_cart
      true
    else
      errors[:base] << I18n.t("activerecord.errors.models.cart_steps.confirmation.base.unable_to_create_order")
      false
    end
  end
  
  private
  
  def create_order_from_cart
    Services::CreateOrderFromCartService.new(cart).call.success?
  end
  
end
