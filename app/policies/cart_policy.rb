class CartPolicy < ApplicationPolicy
  
  def show?
    guest_cart? || user_cart?
  end

  def destroy?
    show? && !record.locked?
  end
  
  def update?
    destroy?
  end
  
  private
  
  def guest_cart?
    user.new_record? && !record.assigned?
  end
  
  def user_cart?
    record.user == user
  end
end
