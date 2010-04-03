class Supervisor < ActiveRecord::Base
set_primary_key "s_id"

#has_many :supervises
#has_many :self_reports
#has_many:projects

validates_presence_of :name, :login_name, :password, :address

validates_format_of :email,
:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
:message => 'must be valid'

validates_uniqueness_of :email,
   :message => 'address has already been used'

validates_confirmation_of :email 
validates_presence_of :email_confirmation
validates_confirmation_of :password 
end
