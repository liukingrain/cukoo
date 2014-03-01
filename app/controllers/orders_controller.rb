class OrdersController < ApplicationController
  before_action :set_order, only: [:update, :show]

  def index
    @orders = policy_scope(Order.ordered)
    @orders = @orders.filtered_by(params[:filter]) unless params[:filter].nil?
    @orders = @orders.page(params[:page]).per(25)
    
    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end
  
  def user_index
    @user = User.find(params[:user_id])
    @orders = policy_scope(@user.orders.ordered)
    
    authorize @user, :show?
    authorize @orders
    
    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end
  
  def show
    authorize @order
    @order = OrderDecorator.decorate(@order)
    @items = OrderItemDecorator.decorate_collection(@order.items)
    @payment = PaymentDecorator.decorate(@order.payment)
    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end
  
  def update
    order_params = params.require(:order).permit(:status)
    authorize(@order)
    
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_path, notice: 'Zamówienie zostało pomyślnie zaktualizowane.' }
        format.json { head :no_content }
      else
        format.html { redirect_to orders_path }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end  
    
  private
  
  def set_order
    @order = Order.find(params[:id])
  end  
  
  def decorated_payment
    PaymentDecorator.decorate(@order.payment)
    # if @order.payment.pay_u?
#       #PayUPaymentDecorator.decorate(@order.payment)
#     else
#       PaymentDecorator.decorate(@order.payment)
#     end
  end
end
