class AddIsPaidToExpenseValue < ActiveRecord::Migration
  def change
    add_column :expense_values, :is_paid, :boolean
    ExpenseValue.update_all(:is_paid => false)
  end
end
