class QuizSessionsController < ApplicationController
  def start
    render({ :template => "quiz_session/start" })
  end

  def create
    user = current_user || User.first # Or current_user if using authentication
    session = QuizSession.create!(user: user)

    previously_answered_ids = QuizSessionQuestion
                                .joins(:quiz_session)
                                .where(quiz_sessions: { user_id: user.id })
                                .pluck(:question_id)

    questions=[]

    questions = Question.order("RANDOM()").limit(10)
    questions.each_with_index do |question, i|
      session.quiz_session_questions.create!(question: question, position: i + 1)

    end
    puts "Questions selected: #{session.quiz_session_questions.count}"
    redirect_to quiz_session_question_path(session, number: 1)
  end


  def question
    session = QuizSession.find(params[:quiz_session_id])
    number = params[:number].to_i

    qsq = session.quiz_session_questions.find_by(position: number)

    if qsq.nil?
      redirect_to authenticated_root_path, alert: "Question not found or session ended"
    else
      @question = qsq.question
      @session = session
      @number = number
      render({ :template => "quiz_session/question" }) # e.g., app/views/quiz_sessions/question.html.erb
    end
  end

  def submit_answer
    session = QuizSession.find(params[:quiz_session_id])
    @number = params[:number].to_i
    selected_option = params[:answer]
    @user_selection=selected_option
    if selected_option.blank?
      flash[:alert] = "You must select an answer."
      redirect_to quiz_session_question_path(session.id, number: @number)
      puts "No answer selected!" if selected_option.blank?
      return
    end

    qsq = session.quiz_session_questions.find_by(position: @number)
    correct = selected_option == qsq.question.correct_option

    qsq.update(answer: selected_option, correct: selected_option == qsq.question.correct_option)

    user = session.user
    topic = qsq.question.topic
    difficulty = qsq.question.difficulty.to_i

    UserTopicCompetency.update_difficulty_band!(
      user: user,
      topic: topic,
      difficulty: qsq.question.difficulty,
      correct: qsq.correct
    )
    redirect_to quiz_session_question_path(session.id, number: @number, show_answer: true) and return
  end
end
