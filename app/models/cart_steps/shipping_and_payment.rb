class CartSteps::ShippingAndPayment < CartSteps::Base
  delegate :shipping_address, :billing_address, :comment=, :comment,
           :shipping_address_attributes, :shipping_address_attributes=,
           :billing_address_attributes, :billing_address_attributes=,
           :shipping_method, :shipping_method=, :shipping_price, :user_id,
           :invoice, :custom_billing_address, :invoice=,
           :custom_billing_address, :custom_billing_address=,
           :payment_method, :payment_method=, :user, to: :cart
  
  
  delegate :phone_number, to: :shipping_address

  validates :shipping_address, associated: true, presence: true
  validates :shipping_method, inclusion: { in: Enumerations::ShippingMethod }
  validates :payment_method, inclusion: { in: Enumerations::PaymentMethod }
  validate :phone_number_presence, if: :require_phone_number?
  
  def save
    begin
      transactional_save
    rescue
      shipping_address.valid?
      billing_address.valid?
      valid?
      false
    end
  end
  
  def require_phone_number?
    true
    #shipping_method.value == "post"
  end

  private  
  
  def phone_number_presence
    if phone_number.blank?
      errors.add "shipping_address", :invalid
      shipping_address.errors.add "phone_number", :blank
    end
  end
  
  def transactional_save
    !!ActiveRecord::Base.transaction do
      cart.billing_address = billing_address
      shipping_address.save!
      billing_address.save!
      if cart.assigned?
        user.shipping_address = shipping_address
        user.billing_address = billing_address
        user.save
      end
      save!
    end
  end
end
