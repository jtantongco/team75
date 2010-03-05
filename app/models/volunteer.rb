class Volunteer < ActiveRecord::Base
  set_primary_key "v_id"

  validates_presence_of :first_name, :last_name, :email, :password, :birthday, :address, :location, :postal_code, :province, :emrg_contact_name, :emrg_contact_relationship 
  validates_associated :student, :volunteer_extra


  has_one :student,         :dependent => :destroy
  has_one :volunteer_extra, :dependent => :destroy

  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  def self.authenticate(user_info)
    find_by_email_and_password(user_info[:email], user_info[:password])
  end
end
