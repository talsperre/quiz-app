class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :admin_user,     only: [:destroy, :new, :create, :edit, :update]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categories_params)
    if @category.save
      flash[:success] = "Congratulations. You have created a new category!!"
      redirect_to categories_url
    else
      render 'new'
    end
  end

  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(categories_params)
      flash[:success] = "Category updated successfully"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category deleted"
    redirect_to categories_url
  end

  private
    def categories_params
      params.require(:category).permit(:name)
    end
end
