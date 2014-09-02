class AdminPolicy < ApplicationPolicy
    
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
  
  def sort_order?
    manage?
  end
  
  private
  
  # Sprawdzanie czy użytkownik jest zalogowany jako administrator.
  def admin?
    admin_user_signed_in? && user.admin?
  end
  
  # Sprawdzanie czy użytkownik jest zalogowany.
  def admin_user_signed_in?
    user.present?   
  end
  
  # Użytkownik może zarządzać jeżeli jest zalogowany jako administrator.
  def manage?
    admin_user_signed_in?
  end
  
  # Użytkownik może czytać jeżeli jest zalogowany jako administrator.
  def read?
    admin_user_signed_in?
  end
end  