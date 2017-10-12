class RenameColumnTypeInTableLifelineToLtype < ActiveRecord::Migration[5.1]
  def change
    rename_column :lifelines, :type, :ltype
  end
end

