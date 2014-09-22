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
  
  private
  
  def product_search_params
    params.permit(:variant_size, :q)
  end
  
end

