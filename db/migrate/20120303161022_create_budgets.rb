class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :title
      t.timestamps
    end
  end
  def self.up
    Budget.delete_All
  end
end
