class AlterIncomeDateColumnType < ActiveRecord::Migration
  def up
    change_column :incomes, :income_date, :date
  end

  def down
  end
end
