class PaymentMethods::PayU
  attr_reader :pos_id, :client_ip, :payment
  
  delegate :order, :shipping_address, :billing_address, to: :payment
  
  def initialize(payment, client_ip = "")
    @payment = payment
    @client_ip = client_ip
  end
  
  def url
    "https://www.platnosci.pl/paygw/UTF/NewPayment"
  end

  def parameters
    params
  end
  
  def sig
    @sig ||= ::PayU::Sig.new(params_for_sig)
  end

  private

  def params
    payment_params.merge(sig: sig.to_s)
  end

  def payment_params
    @payment_params ||= {
      pos_id: ::PayU::POS_ID,
      session_id: payment.id,
      pos_auth_key: ::PayU::POS_AUTH_KEY,
      amount:	(order.amount_due * 100).to_i,
      desc:	I18n.t("payments.pay_u.description", order_id: order.id),
      order_id: order.id,
      first_name:	billing_address.first_name,
      last_name: billing_address.last_name,
      email: order.email,
      client_ip: client_ip,
      ts: Time.now.to_i
    }
  end
  
  def params_for_sig
    @params_for_sig ||= payment_params.merge( key1: ::PayU::KEY1 )
  end
  
end
