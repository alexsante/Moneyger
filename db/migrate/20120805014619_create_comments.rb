class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.string :type
      t.integer :commentable_id
      t.timestamps
    end
  end
end
