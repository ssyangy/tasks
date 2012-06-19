class Task < ActiveRecord::Base
  require 'pp'
  
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"        
  belongs_to :project          
  
  enum_attr :importance, %w(urgent important normal idea)
  enum_attr :due, %w(ASAP, today, tomorrow, 'this week', 'next week', 'this month', 'next month', 'this year')
  # tom. tmr. 2moro.
  
  def self.parse(content)
    task = Task.new
    
    
  end
end
