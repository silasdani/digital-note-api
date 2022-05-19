class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :no
      t.string :text_statement
      t.string :options
      t.integer :option_answer
      t.string :text_answer
      t.string :file_answer
      t.boolean :binary_answer
      t.integer :type
      t.integer :tag
      t.boolean :required
      t.string :description

      t.references :exam, foreign_key: true
      t.timestamps
    end
  end
end
