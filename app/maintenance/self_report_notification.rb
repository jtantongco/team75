require 'app/maintenance/maintenance_methods.rb'

class SelfReportNotification < ActiveRecord::Base
  # This script sends an email to all supervisors with unverified self reports

  MaintenanceMethods.dispatchSelfReports
  puts "Yes, the script ran fine"

end



