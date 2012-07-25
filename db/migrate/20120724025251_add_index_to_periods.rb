class AddIndexToPeriods < ActiveRecord::Migration
  def change
    add_index :periods, :budget_id, :name => "budget_id_ix"
  end
end
