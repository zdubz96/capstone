class AddAnswerToQuizSessionQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :quiz_session_questions, :answer, :string
  end

end
