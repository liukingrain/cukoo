class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :cart
  belongs_to :shipping_address
  belongs_to :billing_address, inverse_of: :order
  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :payment, dependent: :destroy
  
  before_create :generate_auth_token
  after_create Order::Notifier
  after_save Order::Notifier
  
  mount_enumeration :shipping_method, Enumerations::ShippingMethod
  mount_enumeration :payment_method, Enumerations::PaymentMethod
  mount_enumeration :status, Enumerations::OrderStatus
  
  accepts_nested_attributes_for :shipping_address, :billing_address
  
  validates :cart_id, :auth_token, uniqueness: true
  
  def assigned?
    user.present?
  end
  
  def guest?
    !assigned?
  end
  
  def ready?
    status == "ready"
  end
  
  def sent?
    status == "sent"
  end
  
  def paid_at
    payment.success? ? payment.current_status.created_at : nil
  end
  
  def new?
    status == "new"
  end
  
  def canceled?
    status == "canceled"
  end
  
  def amount_due
    items_amount_due + shipping_price.to_f
  end
  
  def items_amount_due
    items.inject(0) { |sum, item| sum + item.amount_due }
  end
  
  def payment_status
    payment.status
  end  
     
  def update_status!(status)
    self.status = status
    save
  end
  
  private
  
  def generate_auth_token
    self.auth_token = SecureRandom.urlsafe_base64(nil, false) while auth_token.nil? || Order.where(auth_token: auth_token).exists?
  end
  
end
