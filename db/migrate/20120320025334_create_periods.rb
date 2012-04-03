class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :budget_id
      t.date :start_date
      t.date :end_date
      t.decimal :beginning_balance

      t.timestamps
    end
  end
end
