class Products::BedclothesController < ApplicationController
  
  def index
    @bedclothes = Product.bedclothes
  end
  
end