# == Schema Information
#
# Table name: questions
#
#  id             :bigint           not null, primary key
#  correct_option :string
#  difficulty     :integer
#  explanation    :string
#  options        :jsonb            not null
#  question       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  topic_id       :integer
#
class Question < ApplicationRecord
  belongs_to :topic
end
