# == Schema Information
#
# Table name: quiz_session_questions
#
#  id              :bigint           not null, primary key
#  answer          :string
#  correct         :boolean
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  question_id     :bigint           not null
#  quiz_session_id :bigint           not null
#
# Indexes
#
#  index_quiz_session_questions_on_question_id      (question_id)
#  index_quiz_session_questions_on_quiz_session_id  (quiz_session_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (quiz_session_id => quiz_sessions.id)
#
class QuizSessionQuestion < ApplicationRecord
  belongs_to :quiz_session
  belongs_to :question
  def correct?
    answer.present? && answer == question.correct_option
  end
end
