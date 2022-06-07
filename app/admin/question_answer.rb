ActiveAdmin.register QuestionAnswer do
  permit_params :no, :text, :option, :selects, :points, :submission_id
end