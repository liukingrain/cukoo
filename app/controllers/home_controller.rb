class HomeController < ApplicationController
  
  def index
    @products = Product.all
  end
  
  def quality
  end
  
end
