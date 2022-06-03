ActiveAdmin.register Question do
  permit_params :no, :text_statement, :options, :selects, :question_type, :tag, :required, :description, :exam_id
end
