class Product < ActiveRecord::Base
  
  has_many :variants, class_name: "ProductVariant", dependent: :destroy
  belongs_to :type, class_name: "ProductType"
  has_one :picture
  
  scope :with_bargain, -> { where("bargain = ?", true) }
  scope :bestsellers, -> { where("bestseller = ?", true) }
  
  accepts_nested_attributes_for :picture
  accepts_nested_attributes_for :variants, allow_destroy: true
  
  def colors
    %w(różowy niebieski biały szary zielony fioletowy żółty czerwony czarny brązowy)
  end
  
  def available_sizes
    variants.map(&:size)
  end
  
  def available_sizes_names
    %s(mała średnia duża)
  end
  
end
