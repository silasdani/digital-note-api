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
FactoryBot.define do
  factory :question do
    no { 1 }
    statement { "MyString" }
    text_answer { "MyString" }
    file_answer { "MyString" }
    option_answer { "MyString" }
    binary_answer { false }
    type { 1 }
    tag { 1 }
    required { false }
    description { "MyString" }
  end
end
