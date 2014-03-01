class Admin::OrdersController < AdminController
  
  def index
    @q = Order.ransack(params[:q])
    @orders = Order.all
    @orders = @q.result.page(params[:page]).per(30)
    
    respond_to do |format|
      format.html
      #format.xlsx { render :xlsx => "daily_reports", :filename => "zamowienia.xlsx" }
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
end