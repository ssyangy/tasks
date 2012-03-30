class AddAuthorToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :author_id, :integer, :null => false, :default => 1
    add_column :tasks, :assignee_id, :integer, :null => false, :default => 1
  end
end
