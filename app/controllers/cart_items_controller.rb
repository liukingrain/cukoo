# -*- coding: utf-8 -*-
class CartItemsController < ApplicationController
  before_filter :load_and_authorize_cart
    
  def create
    respond_to do |format|
      if Services::AddToCartService.new(@cart, params[:cart_item]).call.success?
        format.html { redirect_to cart_url, notice: t("cart.items.add_to_cart_success") }
        format.json { render json: @cart }
      else
        format.html { redirect_to cart_url, alert: t("cart.items.add_to_cart_failed") }
        format.json { render json: @cart }
      end
    end
  end

  private

  def load_and_authorize_cart
    @cart = current_cart
  end
end
