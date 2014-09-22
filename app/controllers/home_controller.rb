class HomeController < ApplicationController
  
  def index
    @products = Product.all
  end
  
  def quality
  end
  
  def terms_of_use
  end
  
end
