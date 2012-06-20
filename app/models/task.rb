class Task < ActiveRecord::Base
  require 'pp'
  
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"        
  belongs_to :project          
  
  enum_attr :due, [['ASAP', 10, 'ASAP'], ['today', 20, 'today'], ['tomorrow', 30, 'tomorrow'], ['this week', 40, 'this week'], ['this month', 50, 'this month'], ['next month', 60, 'next month'], ['this year', 70, 'this year']]
                   
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
