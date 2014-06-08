class ProductSize < ActiveRecord::Base
  has_many :product
  
  validates :kind, uniqueness: true, presence: true
end
