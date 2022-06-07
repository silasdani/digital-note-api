# == Schema Information
#
# Table name: submissions
#
#  id             :bigint           not null, primary key
#  student_name   :string
#  student_email  :string
#  student_points :integer
#  student_grade  :integer
#  student_class  :string
#  start_time     :datetime
#  end_time       :datetime
#  status         :integer          default("started")
#  exam_id        :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_submissions_on_exam_id  (exam_id)
#
FactoryBot.define do
  factory :submission do
    no { "MyString" }
    text { "MyString" }
    option { "MyString" }
    selects { "MyString" }
    points { 1 }
  end
end
