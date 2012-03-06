class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.datetime :expense_date
      t.decimal :amount
      t.boolean :isRecurring
      t.string :title
      t.string :shortcode

      t.timestamps
    end
  end
end
