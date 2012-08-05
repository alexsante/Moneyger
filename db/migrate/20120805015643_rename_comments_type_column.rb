class RenameCommentsTypeColumn < ActiveRecord::Migration
  def up
    rename_column :comments, :type, :commentable_type
  end

  def down
    rename_column :comments, :commentable_type, :type
  end
end
