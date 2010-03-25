class MaintenanceMethods < ActiveRecord::Base
  
   # This method sends emails to all the volunteers who have not signed their volunteer contracts
   def self.volunteerContractReminder

       volunteers = Volunteer.all
       volunteers.each { |v|
	   if !v.contract_signed
	       Emailer.deliver_volunteer_contract_reminder(v.email)
	   end
       }
   end

   # This method sends emails to all volunteers who have an active account but have not signed in for more than 6 months and sets their active_status to 0
   def self.volunteerAccountStatusChecker

       volunteers = Volunteer.all
       volunteers.each { |v|
	   if Time.now - v.last_login > 6.months && v.active_status
	       v.active_status = 0
	       v.save
	       Emailer.deliver_volunteer_deactivation_notification(v.email)
	   end
       }
   end
end

