class CreateQuestionAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :question_answers do |t|
      t.string :no
      t.string :text
      t.string :option
      t.string :selects, array: true, default: []
      t.integer :points
      
      t.timestamps
    end
    
    add_reference :question_answers, :reply, index: true
  end
end
