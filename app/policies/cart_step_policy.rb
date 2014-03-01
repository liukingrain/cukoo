class CartStepPolicy < ApplicationPolicy
  def show?
    record.accessible?
  end

  def update?
    show? && !record.cart.locked?
  end
end
