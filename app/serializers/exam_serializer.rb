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
class ExamSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :access_key, :name, :status, :security, :start_time, :end_time

  attribute :file do |entity|
    if entity.file.attached?
      "#{ENV['SERVER_HOST']}#{Rails.application.routes.url_helpers.rails_blob_path(
        entity.file, only_path: true
      )}"
    end
  end

  attribute :questions do |entity|
    QuestionSerializer.new(entity.questions.includes([:file_attachment])).serializable_hash[:data].pluck(:attributes)
  end

  attribute :replies do |entity|
    ReplySerializer.new(entity.replies).serializable_hash[:data].pluck(:attributes)
  end
end
