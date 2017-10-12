class CreateQStates < ActiveRecord::Migration[5.1]
  def change
    create_table :q_states do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
