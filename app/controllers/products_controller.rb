class ProductsController < ApplicationController
  
  def index
    @products = Product.all
    @products = ProductDecorator.decorate(@products)
  end
  
  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
  
end