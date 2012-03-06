class AddExpenseDateToExpenseValue < ActiveRecord::Migration
  def change
    add_column :expense_values, :expense_date, :datetime

  end
end
