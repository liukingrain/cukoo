module Authorization
  extend ActiveSupport::Concern
  include Pundit
  
  included do
    rescue_from Pundit::NotAuthorizedError, with: :access_denied
    helper_method :can?
  end
  
  private
  
  def can?(action, object)
    policy(object).send("#{action}?")
  end
  
  def access_denied
    if current_user
      redirect_to root_url, alert: t("application.access_denied") 
    else
      store_location
      redirect_to new_user_session_url, alert: t("application.access_login")
    end
  end
end
