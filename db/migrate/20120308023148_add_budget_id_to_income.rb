class AddBudgetIdToIncome < ActiveRecord::Migration
  def change
    add_column :incomes, :budget_id, :integer

  end
end
