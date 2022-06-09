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
FactoryBot.define do
  factory :contestant do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    student_class { "MyString" }
    access_token { "MyString" }
  end
end
