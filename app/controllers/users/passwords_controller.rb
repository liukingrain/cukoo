class Users::PasswordsController < Devise::PasswordsController
  skip_before_filter :require_no_authentication
  before_filter :store_return_location  
  layout :layout_based_on_request, only: [:new]
  
  
  private
  
  def layout_based_on_request
    request.xhr? ? false : "application"
  end
  
  protected

  def store_return_location
    optional_store_location(params[:return_url])
  end
  
  
end
