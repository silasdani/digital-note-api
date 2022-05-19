# == Schema Information
#
# Table name: questions
#
#  id             :bigint           not null, primary key
#  no             :integer
#  text_statement :string
#  options        :string
#  option_answer  :integer
#  text_answer    :string
#  file_answer    :string
#  binary_answer  :boolean
#  type           :integer
#  tag            :integer
#  required       :boolean
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
  serialize :option_answer, Array
  belongs_to :exam, optional: true

  enum tag: { low: 0, moderate: 1, high: 2 }, _prefix: true
  enum type: { boolean: 0, option: 1, text: 2, file: 3 }
end
