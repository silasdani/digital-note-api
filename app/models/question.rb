# == Schema Information
#
# Table name: questions
#
#  id             :bigint           not null, primary key
#  no             :integer
#  text_statement :string
#  options        :string           default([]), is an Array
#  selects        :string           default([]), is an Array
#  question_type  :integer          default("text")
#  tag            :integer          default("low")
#  required       :boolean          default(FALSE)
#  description    :string
#  exam_id        :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_questions_on_exam_id  (exam_id)
#
class Question < ApplicationRecord
  belongs_to :exam
  has_one_attached :file

  enum tag: { low: 0, moderate: 1, high: 2 }, _prefix: true
  enum question_type: { text: 0, option: 1, file: 2, choose: 3 }

  validates :text_statement, :question_type, :no, presence: true
end
