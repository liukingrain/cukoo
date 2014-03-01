class ApplicationPolicy
  attr_reader :user, :record, :session_privileges

  class Scope
    attr_reader :user, :scope, :session_privileges
  
    def initialize(user, session_privileges, scope)
      @user = user || User.new
      @scope = scope
    end
    
    def resolve
      scope
    end
  end
  
  def initialize(user, session_privileges, record)
    @user = user || User.new
    @record = record
    @session_privileges = session_privileges
  end

  def index?
    read?
  end

  def show?
    read?
  end

  def create?
    manage?
  end

  def new?
    create?
  end

  def update?
    manage?
  end

  def edit?
    update?
  end

  def destroy?
    manage?
  end
  
  def sort?
    save_order?    
  end  
  
  def save_order?
    manage?
  end
  
  def read?
    true
  end

  def scope
    Pundit.policy_scope!(user, session_privileges, record.class)
  end

  private
  
  def manage?
    admin?
  end
  
  def admin?
    false
  end

end

