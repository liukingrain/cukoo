class AdminPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end  
    
  def create?
    manage?
  end
  
  def index?
    read?
  end

  def show?
    read?
  end

  def update?
    manage? 
  end

  def destroy?
    manage?
  end 
  
  private
  
  def admin_user_signed_in?
    user.present?   
  end 

  def manage?
    admin_user_signed_in?
  end
  
  def read?
    admin_user_signed_in?
  end  
end  