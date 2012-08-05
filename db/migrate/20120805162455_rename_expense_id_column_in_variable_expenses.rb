class RenameExpenseIdColumnInVariableExpenses < ActiveRecord::Migration
  def up
    rename_column :variable_expenses, :expense_id, :expense_value_id
  end

  def down
    rename_column :variable_expenses, :expense_value_id, :expense_id
  end
end
