class CartSteps::Authentication < CartSteps::Base
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }, if: :required?
  
  delegate :email, :email=, to: :cart
  
  attr_accessor :user
  
  def required?
    !cart.assigned?
  end
  
  def user
    @user ||= User.new
  end
end
