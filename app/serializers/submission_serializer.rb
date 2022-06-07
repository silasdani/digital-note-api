# == Schema Information
#
# Table name: submissions
#
#  id             :bigint           not null, primary key
#  student_name   :string
#  student_email  :string
#  student_points :integer
#  student_grade  :integer
#  student_class  :string
#  start_time     :datetime
#  end_time       :datetime
#  status         :integer          default("started")
#  exam_id        :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_submissions_on_exam_id  (exam_id)
#
class SubmissionSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :student_name, :status, :student_email, :student_points, :end_time, :start_time,
             :student_grade

  attribute :answers do |entity|
    QuestionAnswerSerializer.new(entity.question_answers).serializable_hash[:data].pluck(:attributes)
  end

  attribute :file do |entity|
    if entity.file.attached?
      "#{ENV['SERVER_HOST']}#{Rails.application.routes.url_helpers.rails_blob_path(
        entity.file, only_path: true
      )}"
    end
  end
end
