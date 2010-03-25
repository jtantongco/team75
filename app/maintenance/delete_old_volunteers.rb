require 'app/controllers/application_controller.rb'

class DeleteOldVolunteers < ActiveRecord::Base
  # This is a test script.  It will delete the first volunteer in the database

  vol = Volunteer.find(:first)

  Volunteer.destroy(vol)
  puts "Volunteer with id = #{vol.v_id} has been DESTROYED!"
end



