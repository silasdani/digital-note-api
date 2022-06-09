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
#  contestant_id  :bigint
#
# Indexes
#
#  index_submissions_on_contestant_id  (contestant_id)
#  index_submissions_on_exam_id        (exam_id)
#
class Submission < ApplicationRecord
  belongs_to :exam
  has_many :question_answers
  has_one_attached :file

  enum status: { started: 0, in_progress: 1, completed: 2, graded: 3 }
end
