class Admin::ProductsController < AdminController
  
  def index
    @q = Product.ransack(params[:q])
    @products = Product.all
    @products = @q.result.page(params[:page]).per(30)
    @products = PaginatingDecorator.decorate(@products, with: Admin::ProductDecorator)
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_product_path(@product), notice: 'Pościel została dodana.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    @product.update_attributes(product_params)
    
    respond_to do |format|
      if @product.update_attributes(product_params)
        format.html { redirect_to admin_product_path(@product), notice: 'Pościel została wyedytowana.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    
    respond_to do |format|
      format.html { redirect_to admin_products_url }
    end
  end
  
  private
  
  def product_params 
    params.require(:product).permit(:name, :product_type, :price, :amount, :fabric, :manufacturer, :description, :bargain, :picture,
      color: [], size_attributes: [:kind])    
  end
  
end