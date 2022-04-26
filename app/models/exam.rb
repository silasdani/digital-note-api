# == Schema Information
#
# Table name: exams
#
#  id         :bigint           not null, primary key
#  access_key :string
#  name       :string
#  active     :boolean
#  start_time :datetime
#  end_time   :datetime
#  security   :integer          default("low")
#  status     :integer          default("active")
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_exams_on_user_id  (user_id)
#
class Exam < ApplicationRecord
  belongs_to :user

  enum status: { active: 0, draft: 1, archived: 2, completed: 3 }
  enum security: { low: 0, moderate: 1, high: 2 }, _suffix: true
end
