class Admin::ProductSizesController < AdminController
  
  def index
    @product_sizes = ProductSize.all
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def show
    @product_size = ProductSize.find(params[:id])
  end
  
  def new
    @product_size = ProductSize.new
    
  end
  
  def create
    @product_size = ProductSize.new(product_size_params)
    
    respond_to do |format|
      if @product_size.save
        format.html { redirect_to admin_product_sizes_path, notice: 'Rozmiar został dodany.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def edit
    @product_size = ProductSize.find(params[:id])
  end
  
  def update
    @product_size = ProductSize.find(params[:id])
    @product_size.update_attributes(product_size_params)
    
    respond_to do |format|
      if @product_size.update_attributes(product_params)
        format.html { redirect_to admin_product_path(@product_size), notice: 'Rozmiar został wyedytowany.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @product_size = ProductSize.find(params[:id])
    @product_size.destroy
    
    respond_to do |format|
      format.html { redirect_to admin_products_url }
    end
  end
  
  private
  
  def product_size_params 
    params.require(:product_size).permit(:kind)    
  end
  
end