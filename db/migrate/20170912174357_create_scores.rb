class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.references :user, foreign_key: true
      t.boolean :is_quiz
      t.references :quiz, foreign_key: true
      t.boolean :is_subcategory
      t.references :subcategory, foreign_key: true
      t.boolean :is_category
      t.references :category, foreign_key: true
      t.integer :total

      t.timestamps
    end
  end
end
