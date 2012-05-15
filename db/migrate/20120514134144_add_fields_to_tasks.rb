class AddFieldsToTasks < ActiveRecord::Migration
  def change  
    add_column :tasks, :importance, :enum
  end
end
