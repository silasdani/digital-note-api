class CreateExams < ActiveRecord::Migration[6.1]
  def change
    create_table :exams do |t|
      t.string :access_key
      t.string :name
      t.boolean :active
      t.datetime :start_time
      t.datetime :end_time
      t.integer :security, default: 0
      t.integer :status, default: 0

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
