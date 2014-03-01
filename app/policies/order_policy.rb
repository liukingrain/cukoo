class OrderPolicy < ApplicationPolicy
  
  def index?
    true
  end
  
  def user_index?
    true
  end
  
end


