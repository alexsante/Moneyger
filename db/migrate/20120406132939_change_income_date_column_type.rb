class ChangeIncomeDateColumnType < ActiveRecord::Migration
  def up
    change_column :income_values, :income_date, :date
  end

  def down
  end
end
