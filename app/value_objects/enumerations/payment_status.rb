class Enumerations::PaymentStatus < Enumerations::Base
  PAY_U_STATUSES = %w(1 2 3 4 5 7 99 888)
  
  def self.options
    @options ||= %w(new canceled rejected initiated pending n/a
                    pay_u_brothel success pay_u_bad_status uninitiated)
  end
  
  def self.for_pay_u(status)
    options[PAY_U_STATUSES.index(status)]
  end
  
  private
  
  def translation_key
    "payment_status"
  end
end
