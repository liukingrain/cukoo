class Cart < ActiveRecord::Base
  belongs_to :user
  belongs_to :shipping_address
  belongs_to :billing_address, inverse_of: :cart
  has_many :items, class_name: "CartItem", dependent: :destroy
  has_one :order
  
  mount_enumeration :shipping_method, Enumerations::ShippingMethod, validate: false
  mount_enumeration :payment_method, Enumerations::PaymentMethod, validate: false
  
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :reject_item
  accepts_nested_attributes_for :shipping_address, update_only: true
  accepts_nested_attributes_for :billing_address, update_only: true
  
  def steps
    @steps ||= CartSteps::Collection.new(self)
  end
  
  def assigned?
    !user.nil?
  end
  
  def lock!
    update_attribute(:locked_at, Time.now.utc) or raise ActiveRecord::Rollback
  end
      
  def locked?
    locked_at.present?
  end
  
  def empty?
    items.count == 0
  end
  
  def reject_item(attributes)
    attributes[:id].nil?
  end
  
  def items_amount_due    
    items.inject(0) { |sum, item| sum + item.amount_due }
  end
  
  def items_quantity
    items.inject(0) { |sum, item| sum + item.quantity }
  end
  
  def shipping_address
    if super.nil?
      return user_shipping_address || build_shipping_address
    end
    super
  end
  
  def billing_address
    if super.nil?
      return user_billing_address || build_billing_address
    end
    super
  end
  
  def email
    assigned? ? user.email : super
  end
  
  def shipping
    @shipping ||= Shipping.new(items_amount_due: items_amount_due, address: shipping_address, method: shipping_method)
  end
  
  def amount_due
    items_amount_due + (shipping_price || 0)
  end
  
  def shipping_price
    begin
      shipping_method.calculate_price
    rescue NotImplementedError
      nil
    end
  end
  
  def free_delivery_reached?
    items_amount_due >= Shipping::FREE_OF_CHARGE_THRESHOLD
  end
  
  def amount_to_free_shipping
    Shipping::FREE_OF_CHARGE_THRESHOLD - items_amount_due
  end
  
  private
  
  def user_shipping_address
    @user_shipping_address = assigned? ? user.shipping_address : nil
  end
  
  def user_billing_address
    @user_billing_address = assigned? ? user.billing_address : nil
  end
  
  
  
  
end
