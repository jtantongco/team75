class Volunteer < ActiveRecord::Base
  set_primary_key "v_id"

  has_one :student,         :dependent => :destroy
  has_one :volunteer_extra, :dependent => :destroy
  has_many :self_reports
  has_many :project_feedbacks
  
  has_and_belongs_to_many :projects, :join_table => 'volunteers_projects'
  
  validates_presence_of :first_name, :last_name, :email, :password, :birthday,
    :address, :location, :postal_code, :province,
    :emrg_contact_name, :emrg_contact_relationship 
  validates_associated :student, :volunteer_extra

  validates_format_of :email,
					  :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
					  :message => 'must be valid'
				
  validates_format_of :postal_code,
					  :with => /^[a-zA-Z]\d[a-zA-Z]\s?\d[a-zA-Z]\d$/,
					  :message => 'must be valid'

  validates_uniqueness_of :email,
  						  :message => 'address has already been used'
  						  
  validates_confirmation_of :password
  						 
  def name
    first_name + " " + last_name
  end
  
  # Checks if the current user has joined the project 
  # If s/he has not joined the project, s/he is joined to it.
  # Returns true if the user was joined, false otherwise
  def join_project(project)
    if (!projects.exists?(project))
      projects << project
      true
    else
      false
    end
  end
  
end
