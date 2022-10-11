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
      redirect_to categories_path, notice: t('.created')
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
      redirect_to categories_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @category = Category.find_by(slug: params[:slug])

    @category.destroy
    redirect_to categories_path, notice: t('.destroyed'), status: :see_other
  end

  private

  def category_params
    params.require(:category).permit(:name, :slug)
  end

end
