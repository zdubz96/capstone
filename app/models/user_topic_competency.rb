# == Schema Information
#
# Table name: user_topic_competencies
#
#  id                 :bigint           not null, primary key
#  accuracy           :float
#  attempts           :integer
#  average_difficulty :float
#  correct            :integer
#  easy_attempts      :integer          default(0), not null
#  easy_correct       :integer          default(0), not null
#  hard_attempts      :integer          default(0), not null
#  hard_correct       :integer          default(0), not null
#  medium_attempts    :integer          default(0), not null
#  medium_correct     :integer          default(0), not null
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

  def easy_accuracy
    return 0.0 if easy_attempts.zero?
    easy_correct.to_f / easy_attempts
  end

  def medium_accuracy
    return 0.0 if medium_attempts.zero?
    medium_correct.to_f / medium_attempts
  end

  def hard_accuracy
    return 0.0 if hard_attempts.zero?
    hard_correct.to_f / hard_attempts
  end

  def unlocked_difficulty_range
    return 1..3 if easy_accuracy < 0.8
    return 1..6 if medium_accuracy < 0.8
    1..10
  end
  
  def self.update_difficulty_band!(user:, topic:, difficulty:, correct:)
    competency = find_or_initialize_by(user: user, topic: topic)

    case difficulty
    when 1..3
      competency.easy_attempts += 1
      competency.easy_correct += 1 if correct
    when 4..6
      competency.medium_attempts += 1
      competency.medium_correct += 1 if correct
    when 7..10
      competency.hard_attempts += 1
      competency.hard_correct += 1 if correct
    end

    competency.save!
  end

end
