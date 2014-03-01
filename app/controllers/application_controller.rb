class ApplicationController < ActionController::Base
  
  include Authentication
  include Authorization
  include ReturnPath
  include ShoppingCart
  include Pundit
    
  protect_from_forgery with: :exception
  
end
