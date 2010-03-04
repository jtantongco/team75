class VolunteerExtra < ActiveRecord::Base
  set_primary_key "v_id"
  belongs_to :volunteer, :foreign_key => "v_id"
  validates_presence_of :own_transportation
end
