class CreateLifelines < ActiveRecord::Migration[5.1]
  def change
    create_table :lifelines do |t|
      t.references :quiz, foreign_key: true
      t.references :user, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
