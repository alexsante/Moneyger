class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.datetime :expense_date
      t.decimal :amount
      t.string :frequency
      t.string :title
      t.string :shortcode
      t.integer :budget_id
      t.timestamps
    end
  end
end
