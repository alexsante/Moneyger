class AlterIsFixedExpenseColumn < ActiveRecord::Migration
  def up
    rename_column :expenses, :isFixed, :isfixed
  end

end
