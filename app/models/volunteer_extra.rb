class VolunteerExtra < ActiveRecord::Base
  belongs_to :volunteer, :foreign_key => "v_id"
end
