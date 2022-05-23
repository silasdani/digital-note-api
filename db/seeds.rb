require 'faker'

Setting.create_or_find_by!(key: 'min_version', value: '0.0')
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') 

  User.create!(
    email: "daniel@yahoo.com",
    first_name: "Silas",
    last_name: "Daniel",
    address: "RO",
    username: "miau",
    phone_no: "0711133311",
    password: "password",
    password_confirmation: "password"
  )
  
  (1..3).each do
    questions = []

    (1..3).each do |no|
      questions << Question.new(
        no: no,
        text_statement: Faker::Lorem.question(word_count: 4, supplemental: true),
        question_type: "text"
      )
    end

    exam = Exam.new(
      user_id: User.first.id,
      name: "Love story"
    )

    exam.active!
    exam.low_security!
    exam.questions = questions

    exam.save!

  end
end