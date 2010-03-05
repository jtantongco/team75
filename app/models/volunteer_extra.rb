class VolunteerExtra < ActiveRecord::Base
  set_primary_key "volunteer_id"
  belongs_to :volunteer
  validates_inclusion_of :own_transportation, :in => [true, false]
end
