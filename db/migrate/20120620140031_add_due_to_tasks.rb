class AddDueToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :due, :integer
  end
end
