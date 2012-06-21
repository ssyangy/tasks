class Task < ActiveRecord::Base
  require 'pp'
  
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"        
  belongs_to :project          
  
  enum_attr :due, [['ASAP', 10, 'ASAP'], ['Today', 20, 'Today'], ['Tomorrow', 30, 'Tomorrow'], ['ThisWeek', 40, 'ThisWeek'], ['ThisMonth', 50, 'ThisMonth'], ['NextMonth', 60, 'NextMonth'], ['ThisYear', 70, 'ThisYear']]
                   
#  DueTypes = ['ASAP', 'today', 'tomorrow', 'this week', 'next week', 'this month', 'next month', 'this year']
  # tom. tmr. 2moro.
  
  def self.parse(input)
    task = Task.new
    
    parsed = input.split(' due ')
    if parsed.size == 2
      task.content = parsed[0]
      task.due = parsed[1]
    elsif parsed.size == 1
      task.content = parsed[0]
    else
      # TODO
    end
    
    task
  end
end
