module ReturnPath
  extend ActiveSupport::Concern
  
  included do
    before_filter :load_session_privileges
    after_filter :store_session_privileges
    helper_method :session_privileges
  end
     
  private
  
  def policy_scope(scope)
    @_policy_scoped = true
    policy = Pundit::PolicyFinder.new(scope).scope!
    policy.new(current_user, session_privileges, scope).resolve
  end

  def policy(record)
    scope = Pundit::PolicyFinder.new(record).policy!
    scope.new(current_user, session_privileges, record)
  end

  def session_privileges
    @session_privileges ||= SessionPrivileges.new(cookies.signed)
  end
  
  def load_session_privileges
    if params[:auth_token].present? && !params[:auth_token].in?(session_privileges.order_auth_tokens)
      session_privileges.order_auth_tokens << params[:auth_token]
    end
  end
  
  def store_session_privileges
    session_privileges.store!
  end

  private

  def store_location
    session[:return_to] = request.fullpath
  end

  def optional_store_location(path)
    session[:return_to] = path if path
  end

  def clear_stored_location
    session[:return_to] = nil
  end

end
