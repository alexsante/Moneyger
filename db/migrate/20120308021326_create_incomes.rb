class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.datetime :income_date
      t.decimal :amount
      t.string :frequency
      t.string :title
      t.integer :sort_weight

      t.timestamps
    end
  end
end
