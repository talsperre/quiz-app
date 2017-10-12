class UsersController < ApplicationController
  before_action :logged_out_user,only: [:new, :create]
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :index]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @scores = Score.where(is_quiz: true, user_id: params[:id])
  end

  def index
    @users = User.all
    @quizzes = Quiz.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome, #{@user.name}. Nice to see you back on QuizIt"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def show_past_history
    @scores = Score.where(user_id: current_user.id)
    @quizzes = Quiz.all
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender)
    end

end
