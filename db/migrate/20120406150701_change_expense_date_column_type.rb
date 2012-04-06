class ChangeExpenseDateColumnType < ActiveRecord::Migration
  def up
    change_column :expense_values, :expense_date, :date
  end

  def down
  end
end
