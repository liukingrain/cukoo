class ProductType < ActiveRecord::Base
  has_many :products
  
  validates :kind, uniqueness: true, presence: true
end
