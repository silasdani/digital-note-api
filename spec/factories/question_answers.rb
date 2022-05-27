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
FactoryBot.define do
  factory :question_answer do
    no { "MyString" }
    text { "MyString" }
    option { "MyString" }
    selects { "MyString" }
    points { 1 }
  end
end
