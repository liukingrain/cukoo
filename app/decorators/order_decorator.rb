class OrderDecorator < SummaryDecorator
  
  def amount_due
    h.format_price(model.amount_due)
  end
  
  def user_name
    "#{shipping_address.first_name} #{shipping_address.last_name}"
  end
  
  def address
    "#{shipping_address.street_and_number}, #{shipping_address.postal_code} #{shipping_address.city}"
  end
  
  def phone_number
    shipping_address.phone_number
  end
  
  def billing_data
    model.invoice.present? ? check_billing_address : "Użytkownik nie chce faktury"
  end
  
  def order_partial
    if model.shipping_method == "post" && model.payment_method == "cash_on_delivery"
      "post_without_bank_transfer"
    elsif model.shipping_method == "post" && model.payment_method == "bank_transfer"
      "post_with_bank_transfer"
    elsif model.shipping_method == "personal_receipt" && model.payment_method == "bank_transfer"
      "personal_with_bank_transfer"
    elsif model.shipping_method == "personal_receipt" && model.payment_method == "cash_on_delivery"
      "personal_without_bank_transfer"
    end
  end
  
  private
  
  def check_billing_addres
    model.custom_billing_address.present? ? "Dane takie jak przy dostawie" : billing_address_data
  end
  
  def shipping_address
    model.shipping_address
  end
  
end