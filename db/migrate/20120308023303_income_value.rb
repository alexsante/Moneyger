class IncomeValue < ActiveRecord::Migration
  def up
    create_table :income_values do |t|
      t.datetime :income_date
      t.decimal :amount
      t.integer :income_id
      t.timestamps
    end
  end

  def down
  end
end
