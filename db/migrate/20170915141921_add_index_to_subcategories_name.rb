class AddIndexToSubcategoriesName < ActiveRecord::Migration[5.1]
  def change
    add_index :subcategories, :name, unique: true
  end
end
