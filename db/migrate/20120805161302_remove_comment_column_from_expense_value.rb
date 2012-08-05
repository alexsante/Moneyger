class RemoveCommentColumnFromExpenseValue < ActiveRecord::Migration
  def up
    remove_column :expense_values, :comment
  end

  def down
    add_column :expense_values, :comment
  end
end
