# == Schema Information
#
# Table name: exams
#
#  id          :bigint           not null, primary key
#  access_key  :string
#  name        :string
#  start_time  :datetime
#  end_time    :datetime
#  security    :integer          default("low")
#  status      :integer          default("active")
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#  exam_type   :integer
#
# Indexes
#
#  index_exams_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe "Exams", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
