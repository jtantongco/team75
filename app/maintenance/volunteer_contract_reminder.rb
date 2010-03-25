require 'app/maintenance/maintenance_methods.rb'

class VolunteerContractReminder < ActiveRecord::Base
  # This script sends an email to all the volunteers who have not signed their volunteer contract

  MaintenanceMethods.volunteerContractReminder
  puts "Yes, the script ran fine"

end



