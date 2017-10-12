class QuizzesController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :admin_user,     only: [:destroy, :new, :create, :update, :edit]

  def new
    @quiz = Quiz.new
    @subcategories = Subcategory.all
  end

  def create
    @quiz = Quiz.new(quizzes_params)
    if @quiz.save
      flash[:success] = "Congratulations. You have created a new quiz!!"
      redirect_to quizzes_url
    else
      render 'new'
    end
  end

  def index
    @quizzes = Quiz.all
  end

  def edit
    @quiz = Quiz.find(params[:id])
    @subcategories = Subcategory.all
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update_attributes(quizzes_params)
      flash[:success] = "Quiz updated successfully"
      redirect_to quizzes_path
    else
      render 'edit'
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    flash[:success] = "Quiz deleted"
    redirect_to quizzes_url
  end

  def show_all_quizzes
    subcategory_id = params[:id]
    @quizzes = Quiz.where(subcategory_id: subcategory_id)
  end

  private
    def quizzes_params
      params.require(:quiz).permit(:name, :subcategory_id)
    end
end
