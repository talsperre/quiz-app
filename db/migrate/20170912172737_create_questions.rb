class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :name
      t.text :content
      t.string :type
      t.text :option_one
      t.text :option_two
      t.text :option_three
      t.text :option_four
      t.text :answer
      t.references :quiz, foreign_key: true

      t.timestamps
    end
  end
end
