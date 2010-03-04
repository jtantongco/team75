class VolunteerExtra < ActiveRecord::Base
  set_primary_key "v_id"
  belongs_to :volunteer, :foreign_key => "v_id"
  validates_inclusion_of :own_transportation, :in => [true, false]
end
