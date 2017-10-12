class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.references :user, foreign_key: true
      t.references :quiz, foreign_key: true
      t.integer :count
      t.integer :score
      t.boolean :complete

      t.timestamps
    end
  end
end
