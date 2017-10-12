class AddIndexToQuizzesName < ActiveRecord::Migration[5.1]
  def change
    add_index :quizzes, :name, unique: true
  end
end
