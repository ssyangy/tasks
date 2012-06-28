class Task < ActiveRecord::Base
  require 'pp'
  
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"        
  belongs_to :project          
  
  enum_attr :due, [['OverDue', 0, 'OverDue'], ['ASAP', 10, 'ASAP'], ['Today', 20, 'Today'], 
   ['Tomorrow', 30, 'Tomorrow'], ['ThisWeek', 40, 'ThisWeek'], ['NextWeek', 50, 'NextWeek'], 
   ['ThisMonth', 60, 'ThisMonth'], ['NextMonth', 70, 'NextMonth'], ['ThisYear', 80, 'ThisYear'], ['Nil', 999999, 'Nil']]
  # tom. tmr. 2moro.
  
  def self.parse(input)
    task = Task.new
    
    parsed = input.split(' due ')
    if parsed.size == 2
      task.content = parsed[0]
      
      case parsed[1].strip.downcase
      when 'asap'
        task.due = DUE_ASAP
      when 'today'
        task.due = DUE_TODAY
      when 'tomorrow', 'tmr.', 'tom.', '2moro.'
        task.due = DUE_TOMORROW
      when 'this week', 'thisweek'
        task.due = DUE_THISWEEK
      when 'next week', 'nextweek'
        task.due = DUE_NEXTWEEK
      when 'this month', 'thismonth'
        task.due = DUE_THISMONTH
      when 'next month', 'nextmonth'
        task.due = DUE_NEXTMONTH
      when 'this year', 'thisyear'
        task.due = DUE_THISYEAR
      else
        task.due = DUE_NIL
      end
    elsif parsed.size == 1
      task.content = parsed[0]
      task.due = DUE_NIL
    else
      # TODO
    end
    
    task
  end
end
