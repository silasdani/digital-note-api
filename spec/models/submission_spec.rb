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
require 'rails_helper'

RSpec.describe Submission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
