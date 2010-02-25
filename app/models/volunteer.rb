class Volunteer < ActiveRecord::Base
  set_primary_key "v_id"
  
  has_one :student,
    :foreign_key => "v_id",
    :dependent => :destroy
  
  has_one :volunteer_extra,
    :foreign_key => "v_id",
    :dependent => :destroy
    
  has_many :volunteer_projects,
    :foreign_key => "v_id",
    :dependent => :destroy
    
  has_many :volunteer_project_interests,
    :foreign_key => "v_id",
    :dependent => :destroy
end
