# == Schema Information
#
# Table name: quiz_sessions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_quiz_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class QuizSession < ApplicationRecord
  has_many :quiz_session_questions, dependent: :destroy
  has_many :questions, through: :quiz_session_questions
  belongs_to :user
end
