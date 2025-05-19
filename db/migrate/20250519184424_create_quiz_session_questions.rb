class CreateQuizSessionQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_session_questions do |t|
      t.references :quiz_session, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
