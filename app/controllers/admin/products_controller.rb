class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :index, Product
    
    @datatable = ProductsDatatable.new(self)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_product_path(@product), notice: 'product was successfully created.'
    else
      render :new
    end
  end

  def update
    check_password_params

    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'product was successfully destroyed.'
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :price)
    end
end
