module ShoppingCart
  extend ActiveSupport::Concern
  include ReturnPath
  
  included do
    helper_method :current_cart,
                  :cart_step_path, :cart_step_url,
                  :order_path, :order_url
  end
  
  def current_cart
    @current_cart ||= (current_user ? current_cart_for_user : current_cart_for_guest)
  end
  
  def cart_step_path(step, options = {})
    send("cart_#{step.to_param}_step_path", options)
  end
  
  def cart_step_url(step, options = {})
    send("cart_#{step.to_param}_step_url", options)
  end
  
  def order_url(order, options = {})
    options[:auth_token] = order.auth_token if order.guest?
    super
  end
  
  def order_path(order, options = {})
    options[:auth_token] = order.auth_token if order.guest?
    super
  end
  
  private
  
  def current_cart_for_user
    if current_user.cart.nil? || current_user.cart.empty? || current_user.cart.locked?
      if session[:cart_id]
        cart_from_session
      elsif current_user.cart.nil?
        current_user.create_cart
      end
    end
    return current_user.cart
  end

  def current_cart_for_guest
    if session[:cart_id]
      cart = Cart.find_by_id(session[:cart_id])
      session.delete(:cart_id) if !cart || cart.locked? 
    end   
    
    if session[:cart_id].nil?
      cart = Cart.create!
      session[:cart_id] = cart.id
    end
    return cart
  end

  def cart_from_session
    session_cart = Cart.find_by_id(session[:cart_id])
    session.delete(:cart_id)
    if !session_cart || session_cart.locked?
      current_user.create_cart
    else
      current_user.cart = session_cart
    end
  end 
end
