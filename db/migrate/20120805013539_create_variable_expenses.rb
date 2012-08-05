class CreateVariableExpenses < ActiveRecord::Migration
  def change
    create_table :variable_expenses do |t|
      t.date :expense_date
      t.decimal :amount
      t.integer :expense_id

      t.timestamps
    end
  end
end
