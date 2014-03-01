class PaymentStatus < ActiveRecord::Base
  belongs_to :payment
  
  mount_enumeration :status, Enumerations::PaymentStatus

  after_create Order::Notifier
  
  delegate :order, to: :payment
  
  scope :ordered, lambda { order("created_at DESC") }
  
  def success?
    status == "success"
  end      
  
  def uninitiated?
    status == "uninitiated"
  end
end
