ActiveAdmin.register QuestionAnswer do
  permit_params :no, :text, :option, :selects, :points, :reply_id
end