class AlterIsFixedColumn < ActiveRecord::Migration
  def up
	change_column :expenses, :isFixed, :isfixed
  end

  def down
  end
end
