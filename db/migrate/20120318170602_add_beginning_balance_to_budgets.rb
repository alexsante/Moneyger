class AddBeginningBalanceToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :beginning_balance, :decimal

  end
end
