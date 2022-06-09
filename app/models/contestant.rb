# == Schema Information
#
# Table name: contestants
#
#  id            :bigint           not null, primary key
#  first_name    :string
#  last_name     :string
#  email         :string
#  student_class :string
#  access_token  :string
#  access_key    :string
#  permissions   :string           default(["\"write\"", "\"read\"", "\"send\"", "\"get\""]), is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Contestant < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_one :submission
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  before_create :generate_access_token

  private

  def generate_access_token
    self.access_token = SecureRandom.urlsafe_base64
  end
end
