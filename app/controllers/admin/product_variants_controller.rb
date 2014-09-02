class Admin::ProductVariantsController < AdminController
  before_action :set_product
  before_action :set_product_variant, only: [:show, :edit, :update, :destroy]

  def index
    @product_variants = @product.variants
    authorize @product_variants
  end

  def show
  end

  def new
    @product_variant = @product.variants.build
    authorize @product_variant
  end

  def edit
  end

  def create
    @product_variant = @product.variants.build(product_variant_params)
    authorize @product_variant

    respond_to do |format|
      if @product_variant.save
        format.html { redirect_to admin_product_variants_path(@product), notice: 'Wariant produktu został utworzony.' }
        format.json { render action: 'show', status: :created, location: @product_variant }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product_variant.update(product_variant_params)
        format.html { redirect_to product_variants_url(@product), notice: 'Wariant produktu został zaktualizowany.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product_variant.destroy
    respond_to do |format|
      format.html { redirect_to admin_product_variants_path(@product) }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
  
  def set_product_variant
    @product_variant = @product.variants.find(params[:id])
    authorize @product_variant
  end

  def product_variant_params
    params.require(:product_variant).permit(:price, :product_id, :size)
  end
end
