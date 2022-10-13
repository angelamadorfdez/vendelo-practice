class ProductsController < ApplicationController
  
  def index
    @categories = Category.all.order(name: :asc).load_async
    @products = Product.all.with_attached_photo

    if params[:category]
      @products = @products.where(category_id: Category.where(slug: params[:category]))
    end

    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price])
    end

    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])
    end

    if params[:query].present?
      @products = @products.search_full_text(params[:query])
    end
    
    order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])

    @products = @products.order(order_by).load_async

    @pagy, @products = pagy_countless(@products, items: 12)

  end

  def show
    product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    product
  end

  def update
    if product.update(product_params)
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product.destroy

    redirect_to products_path, notice: t('.destroyed'), status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, :photo)
  end

  def product
    @product = Product.find(params[:id])
  end
end