ActiveAdmin.register Submission do
  permit_params :student_name, :student_email, :student_points, :student_grade, :start_time, :end_time, :status, :exam_id
end
