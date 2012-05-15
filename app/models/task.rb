class Task < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"        
  belongs_to :project          
  
  enum_attr :importance, %w(urgent important normal idea)
end
