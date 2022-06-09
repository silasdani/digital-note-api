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
require 'rails_helper'

RSpec.describe Contestant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
