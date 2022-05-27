# == Schema Information
#
# Table name: replies
#
#  id             :bigint           not null, primary key
#  student_name   :string
#  student_email  :string
#  student_points :integer
#  student_grade  :integer
#  start_time     :datetime
#  end_time       :datetime
#  status         :integer          default("started")
#  exam_id        :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_replies_on_exam_id  (exam_id)
#
require 'rails_helper'

RSpec.describe Reply, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
