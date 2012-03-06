class CreateExpenseValues < ActiveRecord::Migration
  def change
    create_table :expense_values do |t|
      t.integer :expense_id
      t.decimal :amount
      t.text :comment

      t.timestamps
    end
  end
end
