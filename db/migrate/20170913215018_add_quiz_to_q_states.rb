class AddQuizToQStates < ActiveRecord::Migration[5.1]
  def change
    add_reference :q_states, :quiz, foreign_key: true
  end
end
