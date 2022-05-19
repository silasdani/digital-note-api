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
require 'rails_helper'

RSpec.describe Question, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
