class AddDueToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :due, :string, :default => ""
  end
end
