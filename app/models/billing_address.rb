class BillingAddress < Address
  has_one :order
  has_one :cart
  
  validates :city, :country, :postal_code, :street_and_number, presence: true, if: :custom_billing_address?
  validates :company_name, :company_nip, presence: true, if: :invoice?
    
  def invoice?
    addressable.try(:invoice)
  end
  
  def custom_billing_address?
    addressable.try(:custom_billing_address)
  end
  
  def addressable
    cart || order
  end
  
  def first_name
    super || addressable.shipping_address.first_name
  end
  
  def last_name
    super || addressable.shipping_address.last_name
  end
end
