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
class ExamSerializer
  include FastJsonapi::ObjectSerializer
  attributes :access_key, :name, :status, :security, :start_time, :end_time
  attribute :questions do |att|
    qq = []
    att.questions&.each do |q|
      qq << QuestionSerializer.new(q).serializable_hash[:data][:attributes]
    end

    qq
  end
end
