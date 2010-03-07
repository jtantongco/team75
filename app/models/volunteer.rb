class Volunteer < ActiveRecord::Base
  set_primary_key "v_id"

  has_one :student,         :dependent => :destroy
  has_one :volunteer_extra, :dependent => :destroy
  has_many :self_report
  
  validates_presence_of :first_name, :last_name, :email, :password, :birthday,
    :address, :location, :postal_code, :province,
    :emrg_contact_name, :emrg_contact_relationship 
  validates_associated :student, :volunteer_extra

  validates_format_of :email,
					  :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
					  :message => 'Email address must be valid'
				
  validates_format_of :postal_code,
					  :with => /^[a-zA-Z]\d[a-zA-Z]\d[a-zA-Z]\d$/,
					  :message => 'Postal code must be valid'

  validates_uniqueness_of :email,
  						  :message => 'This email address has already been used'
  						 
  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  def self.authenticate(user_info)
    find_by_email_and_password(user_info[:email], user_info[:password])
  end
  
  
  def full_name()
    first_name + " " + last_name
  end
end
