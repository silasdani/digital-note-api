# == Schema Information
#
# Table name: questions
#
#  id             :bigint           not null, primary key
#  no             :integer
#  text_statement :string
#  options        :string           default([]), is an Array
#  selects        :string           default([]), is an Array
#  question_type  :integer          default("text")
#  tag            :integer          default("low")
#  required       :boolean          default(FALSE)
#  description    :string
#  exam_id        :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_questions_on_exam_id  (exam_id)
#
class QuestionSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :no, :text_statement, :options, :selects, :question_type, :tag,
             :required, :description, :exam_id, :created_at, :updated_at

  attribute :file_answer_url do |entity|
    if entity.file.attached?
      "#{ENV['SERVER_HOST']}#{Rails.application.routes.url_helpers.rails_blob_path(
        entity.file, only_path: true
      )}"
    end
  end
end
