class ProductVariant < ActiveRecord::Base
  belongs_to :product
  
  mount_enumeration :size, Enumerations::ProductVariantSize
  
  
end
