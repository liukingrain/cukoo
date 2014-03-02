class Users::SessionsController < Devise::SessionsController
  
  skip_before_filter :require_no_authentication, :only => [ :new, :create ]
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
