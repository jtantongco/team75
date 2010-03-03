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
    
    # If a user matching the credentials is found, returns the User object.
    # If no matching user is found, returns nil.
    def self.authenticate(user_info)
      find_by_email_and_password(user_info[:email], user_info[:password])
    end
end
