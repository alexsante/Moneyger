class AddExpenseStatusToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :status, :string

  end
end
