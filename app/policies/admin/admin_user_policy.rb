class Admin::AdminUserPolicy < AdminPolicy
  class Scope < AdminPolicy::Scope
    def resolve
      if user.admin?
        scope
      else
        scope.where(id: user.id)
      end
    end
  end
  
  def index?
    true
  end
  
  def read?
    manage?
  end
  
  def manage?
    admin?
  end
  
  # Administrator może usuwać tylko innych administratorów.
  def destroy?
    admin? && record != user
  end
end
