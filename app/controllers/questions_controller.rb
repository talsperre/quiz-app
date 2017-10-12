class QuestionsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :index, :edit, :update]
  before_action :admin_user,     only: [:new, :create, :index, :edit, :update]

  def new
    @question = Question.new
    @quizzes = Quiz.all
  end

  def create
    if Quiz.find_by(id: (question_params[:quiz_id]).to_i)
      @quiz = Quiz.find((question_params[:quiz_id]).to_i)
      @question = @quiz.questions.build(question_params)
      if @question.save
        flash[:success] = "Question created!"
        redirect_to new_question_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
    @quizzes = Quiz.all
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "Question updated successfully"
      redirect_to questions_path
    else
      render 'edit'
    end
  end

  def index
    @questions = Question.all
  end

  def destroy
    Question.find(params[:id]).destroy
    flash[:success] = "Question deleted"
    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(:name, :content, :qtype, :option_one, :option_two, :option_three, :option_four, :answer, :quiz_id)
    end
end
