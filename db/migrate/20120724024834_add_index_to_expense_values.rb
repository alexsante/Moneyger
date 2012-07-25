class AddIndexToExpenseValues < ActiveRecord::Migration
  def change
    add_index :expense_values, :expense_id, :name => "expense_id_ix"
  end
end
