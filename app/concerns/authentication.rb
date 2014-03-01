module Authentication
  extend ActiveSupport::Concern
  
  included do
    before_filter :configure_devise_parameters, if: :devise_controller?
  end
  
  def after_sign_out_path_for(resource)
    session[:return_to] = root_path
  end 
  
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      stored_location = session[:return_to]
      clear_stored_location
      (stored_location.nil?) ? root_path : stored_location.to_s
    else
      super
    end
  end 
  
  private
  
  def configure_devise_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:password, :email) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :password, :password_confirmation, :email, :terms) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :password, :password_confirmation, :email, :current_password, shipping_address_attributes: [ :street_and_number, :phone_number, :city, :postal_code, :id ]) }
  end
  
end
