class ShippingRate < ActiveRecord::Base
  
  mount_enumeration :shipping_method, Enumerations::ShippingMethod

end