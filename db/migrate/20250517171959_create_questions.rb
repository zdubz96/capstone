class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :option_1
      t.string :option_2
      t.string :option_3
      t.string :option_4
      t.string :correct_option
      t.string :explanation
      t.integer :topic_id
      t.string :difficulty

      t.timestamps
    end
  end
end
