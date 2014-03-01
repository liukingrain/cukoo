# -*- coding: utf-8 -*-
class CartsController < ApplicationController
  before_filter :load_and_authorize_cart
    
  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to cart_url, notice: t("cart.destroyed") }
      format.json { head :ok }
    end
  end
  
  private
  
  def load_and_authorize_cart
    @cart = current_cart
    authorize @cart
  end
end
