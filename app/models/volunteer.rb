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
					  :message => 'must be valid'
				
  validates_format_of :postal_code,
					  :with => /^[a-zA-Z]\d[a-zA-Z]\d[a-zA-Z]\d$/,
					  :message => 'must be valid'

  validates_uniqueness_of :email,
  						  :message => 'address has already been used'
  						  
  validates_confirmation_of :password
  						 
  def name()
    first_name + " " + last_name
  end
end
