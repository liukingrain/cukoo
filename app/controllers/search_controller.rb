class SearchController < ApplicationController

  def index
    @search_results = Product.search(params[:search], :ranker => :proximity, :match_mode => :any)
  end
  

  
end