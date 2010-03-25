class VolunteersProjects < ActiveRecord::Base
  
  belongs_to :volunteer
  belongs_to :project
  
  validates_presence_of :volunteer_id, :project_id

end
