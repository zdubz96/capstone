class AddDifficultyBandsToUserTopicCompetencies < ActiveRecord::Migration[7.1]
  def change
    add_column :user_topic_competencies, :easy_attempts, :integer, default: 0, null: false
    add_column :user_topic_competencies, :easy_correct,  :integer, default: 0, null: false
    add_column :user_topic_competencies, :medium_attempts, :integer, default: 0, null: false
    add_column :user_topic_competencies, :medium_correct,  :integer, default: 0, null: false
    add_column :user_topic_competencies, :hard_attempts, :integer, default: 0, null: false
    add_column :user_topic_competencies, :hard_correct,  :integer, default: 0, null: false
  end
end
