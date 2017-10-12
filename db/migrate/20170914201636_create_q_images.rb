class CreateQImages < ActiveRecord::Migration[5.1]
  def change
    create_table :q_images do |t|
      t.references :question, foreign_key: true
      t.string :img

      t.timestamps
    end
  end
end
