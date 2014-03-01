class CartSteps::Fresh < CartSteps::Base
  delegate :items, :items_attributes=, :items_attributes, to: :cart
  
  validates :items, presence: true, associated: true
end
