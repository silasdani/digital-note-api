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
  belongs_to :user, optional: true
  has_many :questions
  validates :access_key, uniqueness: { on: :create, message: 'Access key must be unique' }

  enum status: { active: 0, draft: 1, archived: 2, completed: 3 }
  enum security: { low: 0, moderate: 1, high: 2 }, _suffix: true
  before_validation :generate_access_key

  def generate_access_key
    o = [('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
    self.access_key = (0...5).map { o[rand(o.length)] }.join
  end
end
