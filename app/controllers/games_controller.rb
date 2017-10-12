class GamesController < ApplicationController
  before_action :logged_in_user, only: [:play, :state_update, :leaderboard]

  def play
    userid = current_user.id
    qid = params[:id]
    @is_new = true
    if State.find_by(user_id: userid, quiz_id: qid)
      @is_new = false
      @qzid = params[:id]
      @state = State.find_by(user_id: userid, quiz_id: qid)
      @qstate = QState.find_by(user_id: userid, quiz_id: qid)
      @question = Question.find_by(id: @qstate.question_id)
      if @question.qtype == "Image"
        @im = QImage.find_by(question_id: @question.id).img
      end
    else
      State.create(user_id: userid, quiz_id: qid, count: 0, score: 0, complete: false)
      @questions = Question.where(quiz_id: qid)
      @questions.each do |question|
        QState.create(user_id: userid, question_id: question.id, quiz_id: question.quiz_id)
      end
      @qzid = params[:id]
      @state = State.find_by(user_id: userid, quiz_id: qid)
      @qstate = QState.find_by(user_id: userid, quiz_id: qid)
      @question = Question.find_by(id: @qstate.question_id)
      if @question.qtype == "Image"
        @im = QImage.find_by(question_id: @question.id).img
      end
    end
  end

  def state_update
    questionid = params[:question_id]
    userid = current_user.id
    quizid = params[:quiz_id]
    question = Question.find(questionid)
    qstate = QState.find_by(user_id: userid, question_id: questionid)
    qstate.destroy
    state = State.find_by(user_id: userid, quiz_id: quizid)
    state.count += 1
    answers = question.answer
    user_answer = "#{params[:checkone]}#{params[:checktwo]}#{params[:checkthree]}#{params[:checkfour]}"
    if user_answer == answers
      state.score += 1
    end
    state.save
    flag = 0
    old_score = 0
    if state.count == 5
      state.complete = true
      state.save
      if Score.find_by(user_id: userid, quiz_id: quizid)
        score1 = Score.find_by(user_id: userid, quiz_id: quizid)
        old_score = score1.total
        if score1.total < state.score
          flag = 1
          score1.total = state.score
        end
        score1.save
      else
        Score.create(user_id: userid, is_quiz: true, quiz_id: quizid, is_subcategory: false,
                              subcategory_id: nil, is_category: false, category_id: nil, total: state.score)
      end

      quiz = Quiz.find(quizid)
      subcategory = quiz.subcategory
      category = subcategory.category

      if Score.find_by(user_id: userid, subcategory_id: subcategory.id)
        score2 = Score.find_by(user_id: userid, subcategory_id: subcategory.id)
        if flag
          score2.total += -old_score + state.score
        end
        score2.save
      else
        Score.create(user_id: userid, is_quiz: false, quiz_id: nil, is_subcategory: true,
                     subcategory_id: subcategory.id, is_category: false, category_id: nil, total: state.score)
      end

      if Score.find_by(user_id: userid, category_id: category.id)
        score3 = Score.find_by(user_id: userid, category_id: category.id)
        if flag
          score3.total += -old_score + state.score
        end
        score3.save
      else
        Score.create(user_id: userid, is_quiz: false, quiz_id: nil, is_subcategory: false,
                     subcategory_id: nil, is_category: true, category_id: category.id, total: state.score)
      end
      state.destroy
      fifty_lifeline = Lifeline.find_by(user_id: current_user.id, quiz_id: quizid, ltype: 'fifty-fifty')
      if fifty_lifeline
        fifty_lifeline.destroy
      end
      audience_lifeline = Lifeline.find_by(user_id: current_user.id, quiz_id: quizid, ltype: 'audience-poll')
      if audience_lifeline
        audience_lifeline.destroy
      end
      redirect_to leaderboard_path(3, quizid)
    else
      redirect_to play_url(quizid)
    end
  end

  def show_leaderboard
    type_id = params[:id].to_i
    row_id = params[:row_id].to_i
    if type_id == 1
      @scoreboards = Score.where(is_category: true, category_id: row_id).order("total DESC")
      @category = Category.find(row_id)
    elsif type_id == 2
      @scoreboards = Score.where(is_subcategory: true, subcategory_id: row_id).order("total DESC")
      @subcategory = Subcategory.find(row_id)
    elsif type_id == 3
      @scoreboards = Score.where(is_quiz: true, quiz_id: row_id).order("total DESC")
      @quiz = Quiz.find(row_id)
    end
  end

  def show_two_options
    quizid = params[:quiz_id]
    questionid = params[:question_id]
    question = Question.find_by(id: questionid)
    puts("Hello show two options")
    if Lifeline.find_by(user_id: current_user.id, quiz_id: quizid, ltype: 'fifty-fifty')
      @answer = 'Sorry!! You have already used this lifeline'
    else
      Lifeline.create(user_id: current_user.id, quiz_id: quizid, ltype: 'fifty-fifty')
      if question.qtype == "Image" || question.qtype == "Single"
        if question.answer == "A"
          @answer = "A, B"
        else
          @answer = "#{question.answer}, A"
        end
      else
        @answer = 'Sorry!! This lifeline is only for single correct questions'
      end
    end
  end

  def audience_poll
    quizid = params[:quiz_id]
    questionid = params[:question_id]
    question = Question.find_by(id: questionid)
    if Lifeline.find_by(user_id: current_user.id, quiz_id: quizid, ltype: 'audience-poll')
      @answer = 'Sorry!! You have already used this lifeline'
    else
      Lifeline.create(user_id: current_user.id, quiz_id: quizid, ltype: 'audience-poll')
      if question.qtype == 'Image' || question.qtype == 'Single'
        rand_num = rand
        if rand_num <= 0.8
          @answer = question.answer
        else
          @answer = 'C'
        end
      else
        @answer = 'Sorry!! This lifeline is only for single correct questions'
      end
    end
  end
end