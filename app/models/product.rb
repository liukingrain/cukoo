class Product < ActiveRecord::Base
  belongs_to :size, class_name: "ProductSize"
  belongs_to :type, class_name: "ProductType"
  has_one :picture
  
  scope :bedclothes, -> { where("product_type = ?", "bedclothes") }
  scope :sheet, -> { where("product_type = ?", "sheet") }
  scope :blanket, -> { where("product_type = ?", "blanket") }
  scope :bathrobe, -> { where("product_type = ?", "bathrobe") }
  scope :bedspread, -> { where("product_type = ?", "bedspread") }
  scope :pillowslip, -> { where("product_type = ?", "pillowslip") }
  scope :with_bargain, -> { where("bargain = ?", true) }
  scope :bestsellers, -> { where("bestseller = ?", true) }
  
  accepts_nested_attributes_for :picture
  
  def colors
    %w(różowy niebieski biały szary zielony fioletowy żółty czerwony czarny brązowy)
  end
  
  def picture_of_product
    picture ||= build_picture
  end
  
end
