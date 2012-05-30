class AlterIsFixedExpenseColumn < ActiveRecord::Migration
  def up
    rename_column :expenses, :isfixed, :isfixed
  end

end
