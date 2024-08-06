class CreateJoinTableStudentBook < ActiveRecord::Migration[7.1]
  def change
    create_join_table :students, :books do |t|
      t.index [:student_id, :book_id]
      t.index [:book_id, :student_id]
    end
  end
end
