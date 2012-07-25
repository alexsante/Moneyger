class AddIndexToIncomeValues < ActiveRecord::Migration
  def change
    add_index :income_values, :income_id, :name => "income_id_ix"
  end
end
