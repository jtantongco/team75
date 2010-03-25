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

   # This method checks all the volunteers 
end

