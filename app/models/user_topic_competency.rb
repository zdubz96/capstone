# == Schema Information
#
# Table name: user_topic_competencies
#
#  id                 :bigint           not null, primary key
#  accuracy           :float
#  attempts           :integer
#  average_difficulty :float
#  correct            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  topic_id           :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_user_topic_competencies_on_topic_id  (topic_id)
#  index_user_topic_competencies_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#  fk_rails_...  (user_id => users.id)
#
class UserTopicCompetency < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  def update_stats!(correct:, difficulty:)
  self.attempts ||= 0
  self.correct ||= 0
  self.average_difficulty ||= 0.0
  self.accuracy ||= 0.0

  self.attempts += 1
  self.correct += 1 if correct

  self.average_difficulty = ((average_difficulty * (attempts - 1)) + difficulty) / attempts.to_f
  self.accuracy = self.correct.to_f / self.attempts.to_f

  save!
end
end
