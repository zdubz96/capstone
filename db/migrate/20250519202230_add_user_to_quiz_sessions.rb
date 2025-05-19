class AddUserToQuizSessions < ActiveRecord::Migration[7.1]
  def change
    add_reference :quiz_sessions, :user, null: true, foreign_key: true
  end
end
