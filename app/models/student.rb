class Student < ActiveRecord::Base
  set_primary_key "volunteer_id"
  belongs_to :volunteer
  
  validates_presence_of     :student_id,  :faculty,     :program
  validates_numericality_of :student_id,  :only_integer => true 
end
