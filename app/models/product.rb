class Product < ActiveRecord::Base
  belongs_to :size, class_name: "ProductSize"
  belongs_to :type, class_name: "ProductType"
  
  scope :bedclothes, -> { where("product_type = ?", "bedclothes") }
  scope :sheet, -> { where("product_type = ?", "sheet") }
  scope :blanket, -> { where("product_type = ?", "blanket") }
  scope :bathrobe, -> { where("product_type = ?", "bathrobe") }
  scope :bedspread, -> { where("product_type = ?", "bedspread") }
  scope :pillowslip, -> { where("product_type = ?", "pillowslip") }
  scope :with_bargain, -> { where("bargain = ?", true) }
  
  mount_uploader :picture, PictureUploader
  
  def colors
    %w(różowy niebieski biały szary zielony fioletowy żółty czerwony czarny brązowy)
  end
  
end
