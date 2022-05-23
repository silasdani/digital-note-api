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
  set_key_transform :camel_lower
  attributes :access_key, :name, :status, :security, :start_time, :end_time

  attribute :file_url do |entity|
    if entity.file.attached?
      "#{ENV['SERVER_HOST']}#{Rails.application.routes.url_helpers.rails_blob_path(
        entity.file, only_path: true
      )}"
    end
  end

  attribute :questions do |entity|
    questions = []
    entity.questions&.each do |q|
      questions << QuestionSerializer.new(q).serializable_hash[:data][:attributes]
    end

    questions
  end
end
