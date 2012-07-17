class AddUserIdToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :user_id, :integer

  end
  def down
    remove_column :budgets, :user_id
  end
end
