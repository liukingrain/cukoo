class Payment < ActiveRecord::Base
  has_many :statuses, class_name: "PaymentStatus", dependent: :destroy
  has_one :current_status, -> { ordered }, class_name: "PaymentStatus"
  belongs_to :order
  
  mount_enumeration :method, Enumerations::PaymentMethod
  
  validates :amount, numericality: { minimum: 0 }
  
  delegate :shipping_address, to: :order
  delegate :billing_address, to: :order
  delegate :pay_u?, :cash_on_delivery?, to: :method
  delegate :status, :success?, :uninitiated?, to: :current_status
end
