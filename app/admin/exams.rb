ActiveAdmin.register Exam do
  permit_params :access_key, :name, :start_time, :end_time, :security, :status, :user_id, :questions, :replies
end
