class CreateSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :submissions do |t|
      t.string :student_name
      t.string :student_email
      t.integer :student_points
      t.integer :student_grade
      t.string :student_class
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status, default: 0
      
      t.references :exam, foreign_key: true
      t.timestamps
    end
  end
end
