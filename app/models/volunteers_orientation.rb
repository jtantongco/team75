class VolunteersOrientation < ActiveRecord::Base
  
  belongs_to :volunteer
  belongs_to :orientation
  
  validates_presence_of :volunteer_id, :orientation_id

end
