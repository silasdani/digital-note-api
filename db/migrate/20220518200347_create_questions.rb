class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :no
      t.string :text_statement
      t.string :options, array: true, default: []
      t.string :selects, array: true, default: []
      t.integer :question_type, default: 0
      t.integer :tag, default: 0
      t.boolean :required, default: false
      t.string :description

      t.references :exam, foreign_key: true
      t.timestamps
    end
  end
end
