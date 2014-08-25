class Product < ActiveRecord::Base
  SMALL_SIZE = "160x200"
  MEDIUM_SIZE = "180x200"
  BIG_SIZE = "200x220"
  
  belongs_to :size, class_name: "ProductSize"
  belongs_to :type, class_name: "ProductType"
  has_one :picture
  
  scope :with_bargain, -> { where("bargain = ?", true) }
  scope :bestsellers, -> { where("bestseller = ?", true) }
  scope :small_bedclothes, -> { joins(:size).where("kind = ?", SMALL_SIZE) }
  scope :medium_bedclothes, -> { joins(:size).where("kind = ?", MEDIUM_SIZE) }
  scope :big_bedclothes, -> { joins(:size).where("kind = ?", BIG_SIZE) }
  
  accepts_nested_attributes_for :picture
  
  def colors
    %w(różowy niebieski biały szary zielony fioletowy żółty czerwony czarny brązowy)
  end
  
end
