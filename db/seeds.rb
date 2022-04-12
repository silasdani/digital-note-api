Setting.create_or_find_by!(key: 'min_version', value: '0.0')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?