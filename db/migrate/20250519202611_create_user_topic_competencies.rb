class CreateUserTopicCompetencies < ActiveRecord::Migration[7.1]
  def change
    create_table :user_topic_competencies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.float :accuracy
      t.float :average_difficulty
      t.integer :attempts
      t.integer :correct

      t.timestamps
    end
  end
end
