require 'app/maintenance/maintenance_methods.rb'

class VolunteerActiveStatusChecker < ActiveRecord::Base
  # This script sends an email to all the volunteers who have not signed their volunteer contract

  MaintenanceMethods.volunteerAccountStatusChecker
  puts "Yes, the script ran fine"

end



