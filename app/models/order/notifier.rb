class Order::Notifier
  attr_reader :record, :callback
  
  def initialize(record, callback)
    @record = record
    @callback = callback
  end
  
  def self.after_create(record)
    begin
      self.new(record, "after_create").dispatch
    rescue
    end
  end
  
  def self.after_save(record)
    begin
      self.new(record, "after_save").dispatch
    rescue
    end
  end
      
  def dispatch
    send(method_name)
  end

  private
  
  def after_save_order
    order_sent if record.sent? && record.status_changed?
    order_canceled if record.canceled? && record.status_changed?
  end
  
  def after_create_payment_status
    if record.success? 
      order_paid if record.order.new?
      new_virtualo_transaction if record.order.any_ditital_items?
    end
  end
  
  def after_create_order
    new_order
  end

  def method_name
    [callback, record.class.to_s.underscore].join("_")
  end
  
  def order_sent
    OrdersMailer.order_sent(record).deliver
  end
  
  def order_canceled
    OrdersMailer.order_canceled(record).deliver
  end
  
  def order_paid
    record.order.update_status!("ready")
    OrdersMailer.order_paid(record.order).deliver
  end
  
  def new_order
    OrdersMailer.new_order(record).deliver    
  end
    
end

