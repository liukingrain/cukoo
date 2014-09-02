class ProductVariant < ActiveRecord::Base
  belongs_to :product
  
  delegate :size, :price, to: :product
  
  mount_enumeration :size, Enumerations::ProductVariantSize
  
  
end
