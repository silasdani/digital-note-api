# == Schema Information
#
# Table name: question_answers
#
#  id         :bigint           not null, primary key
#  no         :string
#  text       :string
#  option     :string
#  selects    :string           default([]), is an Array
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  reply_id   :bigint
#
# Indexes
#
#  index_question_answers_on_reply_id  (reply_id)
#
class QuestionAnswer < ApplicationRecord
  belongs_to :reply
  has_one_attached :file
end
