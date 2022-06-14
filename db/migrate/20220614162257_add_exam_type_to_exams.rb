class AddExamTypeToExams < ActiveRecord::Migration[6.1]
  def change
    add_column :exams, :exam_type, :integer
  end
end
