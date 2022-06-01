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
end