class CategoriesController < ApplicationController

  def show
    @category = Category.find_by(slug: params[:slug])
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end 

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
    @category = Category.find_by(slug: params[:slug])
  end

  def update
    @category = Category.find_by(slug: params[:slug])

    if @category.update(category_params)
      redirect_to product_path(@category.slug), notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end

  end






  def destroy
  end


  private

  def category_params
    params.require(:category).permit(:name, :slug)
  end

end
