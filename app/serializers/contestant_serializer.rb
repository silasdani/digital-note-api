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
class ContestantSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :email, :student_class, :permissions, :access_token, :access_key, :created_at, :updated_at 

  attribute :name do |entity|
    "#{entity.first_name} #{entity.last_name}"
  end
end
