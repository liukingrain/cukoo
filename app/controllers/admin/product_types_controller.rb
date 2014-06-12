class Admin::ProductTypesController < AdminController
  
  def index
    @product_types = ProductType.all
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def show
    @product_type = ProductType.find(params[:id])
  end
  
  def new
    @product_type = ProductType.new
    
  end
  
  def create
    @product_type = ProductType.new(product_type_params)
    
    respond_to do |format|
      if @product_type.save
        format.html { redirect_to admin_product_types_path, notice: 'Typ produktu został dodany.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def edit
    @product_type = ProductType.find(params[:id])
  end
  
  def update
    @product_type = ProductType.find(params[:id])
    @product_type.update_attributes(product_type_params)
    
    respond_to do |format|
      if @product_type.update_attributes(product_params)
        format.html { redirect_to admin_product_path(@product_type), notice: 'Typ produktu został wyedytowany.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @product_type = ProductType.find(params[:id])
    @product_type.destroy
    
    respond_to do |format|
      format.html { redirect_to admin_products_url }
    end
  end
  
  private
  
  def product_type_params 
    params.require(:product_type).permit(:kind)    
  end
  
end