class SubcategoriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create]
  before_action :admin_user,     only: [:destroy, :new, :create, :update, :edit]

  def new
    @subcategory = Subcategory.new
    @categories = Category.all
  end

  def create
    @subcategory = Subcategory.new(subcategories_params)
    if @subcategory.save
      flash[:success] = "Congratulations. You have created a new subcategory!!"
      redirect_to subcategories_url
    else
      render 'new'
    end
  end

  def index
    @subcategories = Subcategory.all
  end

  def edit
    @subcategory = Subcategory.find(params[:id])
    @categories = Category.all
  end

  def update
    @subcategory = Subcategory.find(params[:id])
    if @subcategory.update_attributes(subcategories_params)
      flash[:success] = "Subcategory updated successfully"
      redirect_to subcategories_path
    else
      render 'edit'
    end
  end

  def destroy
    Subcategory.find(params[:id]).destroy
    flash[:success] = "Category deleted"
    redirect_to categories_url
  end

  def show_all_subcategories
    category_id = params[:id]
    @subcategories = Subcategory.where(category_id: category_id)
  end

  private
    def subcategories_params
      params.require(:subcategory).permit(:name, :category_id)
    end
end
