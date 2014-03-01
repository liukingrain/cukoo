class Product < ActiveRecord::Base
  
  scope :bedclothes, -> { where("product_type = ?", "bedclothes") }
  scope :sheet, -> { where("product_type = ?", "sheet") }
  scope :blanket, -> { where("product_type = ?", "blanket") }
  scope :bathrobe, -> { where("product_type = ?", "bathrobe") }
  scope :bedspread, -> { where("product_type = ?", "bedspread") }
  scope :pillowslip, -> { where("product_type = ?", "pillowslip") }
  scope :with_bargain, -> { where("bargain = ?", true) }
  
  mount_uploader :picture, PictureUploader
  
  mount_enumeration :product_type, Enumerations::ProductType
  mount_enumeration :size, Enumerations::Size
  
  def colors
    %w(różowy niebieski biały szary zielony fioletowy żółty czerwony czarny brązowy)
  end
  
end
