class Admin::ProductsController < AdminController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
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
  end
  
  def new
    @product = Product.new
    @product.picture = Picture.new
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
  end
  
  def update
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
    @product.destroy
    
    respond_to do |format|
      format.html { redirect_to admin_products_url }
    end
  end
  
  private
  
  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end
  
  def product_params 
    params.require(:product).permit(:name, :product_type, :amount, :fabric, :manufacturer, :description, :bargain, :bestseller,
      color: [],
      picture_attributes: [:full_view, :zoom, :pattern, :full_view_thumb, :zoom_thumb, :pattern_thumb, :id]
      )    
  end
  
end