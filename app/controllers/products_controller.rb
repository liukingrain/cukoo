class ProductsController < ApplicationController
  
  def index
    @product_search = ProductSearch.new(product_search_params)
    @products = PaginatingDecorator.decorate(@product_search.resolve, with: Product::IndexDecorator)
    respond_to(:html)
  end
  
  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def bargain
    @products = Product.with_bargain
  end
  
  def small_bedclothes
    @products = Product.small_bedclothes
  end
  
  def medium_bedclothes
    @products = Product.medium_bedclothes
  end
  
  def big_bedclothes
    @products = Product.big_bedclothes
  end
  
  private
  
  def product_search_params
    params.permit(:size_id, :q)
  end
  
end

