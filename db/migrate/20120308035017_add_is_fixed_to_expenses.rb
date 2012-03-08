class AddIsFixedToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :isFixed, :boolean

  end
end
