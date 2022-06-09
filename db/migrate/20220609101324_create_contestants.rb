class CreateContestants < ActiveRecord::Migration[6.1]
  def change
    create_table :contestants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :student_class
      t.string :access_token
      t.string :access_key
      t.string :permissions, array: true, default: ['write', 'read', 'send', 'get']

      t.timestamps
    end
    
    add_reference :submissions, :contestant
  end
end
