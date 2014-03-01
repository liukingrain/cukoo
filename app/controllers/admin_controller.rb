class AdminController < ApplicationController
  skip_before_filter :check_user_registration
  before_filter :authenticate_admin_user!
  layout "admin"
  
end