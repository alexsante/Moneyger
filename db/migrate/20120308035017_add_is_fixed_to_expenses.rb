class AddIsFixedToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :isfixed, :boolean

  end
end
