# == Schema Information
#
# Table name: exams
#
#  id         :bigint           not null, primary key
#  access_key :string
#  name       :string
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
  has_many :questions, dependent: :destroy
  has_many :submissions, dependent: :destroy
  validates :access_key, uniqueness: { on: :create, message: I18n.t('exam.validation.access_key') }
  validates :start_time, :end_time, :name, presence: true
  before_create :generate_access_key

  has_one_attached :file
  enum status: { active: 0, draft: 1, archived: 2, completed: 3 }
  enum security: { low: 0, moderate: 1, high: 2 }, _suffix: true

  scope :active, -> { where(status: 0) }
  scope :draft, -> { where(status: 1) }
  scope :archived, -> { where(status: 2) }
  scope :completed, -> { where(status: 3) }

  private

  def generate_access_key
    o = [('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
    self.access_key = (0...5).map { o[rand(o.length)] }.join
  end
end
