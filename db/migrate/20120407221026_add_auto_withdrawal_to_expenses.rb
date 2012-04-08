class AddAutoWithdrawalToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :auto_withdrawal, :integer, :default => 0

  end
end
