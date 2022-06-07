ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end

    columns do
      column do
        panel 'Recent Exams' do
          ul do
            Exam.take(5).map do |exam|
              li link_to(exam.name, admin_exam_path(exam))
            end
          end
        end
      end

      column do
        panel 'Some Teachers' do
          ul do
            User.take(5).map do |user|
              li link_to(user.full_name, admin_user_path(user))
            end
          end
        end
      end
    end
  end
end
