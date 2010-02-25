class Volunteer < ActiveRecord::Base
  set_primary_key "v_id"
  has_one :volunteer_extras
end
