class AlterIsFixedColumn < ActiveRecord::Migration
  def up
	rename_column :expenses, :isFixed, :isfixed
  end

  def down
  end
end
