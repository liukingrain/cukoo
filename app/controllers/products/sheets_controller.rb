class Products::SheetsController < ApplicationController
  
  def index
    @sheets = Product.sheet
  end
  
end