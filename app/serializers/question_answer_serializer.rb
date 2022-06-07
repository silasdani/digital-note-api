# == Schema Information
#
# Table name: question_answers
#
#  id            :bigint           not null, primary key
#  no            :string
#  text          :string
#  option        :string
#  selects       :string           default([]), is an Array
#  points        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  submission_id :bigint
#
# Indexes
#
#  index_question_answers_on_submission_id  (submission_id)
#
class QuestionAnswerSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :no, :text, :option, :selects, :created_at, :updated_at

  attribute :file do |entity|
    if entity.file.attached?
      "#{ENV['SERVER_HOST']}#{Rails.application.routes.url_helpers.rails_blob_path(
        entity.file, only_path: true
      )}"
    end
  end
end
