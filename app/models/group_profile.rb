class GroupProfile < ActiveRecord::Base
set_primary_key "Gid"

validates_presence_of :Name, :NumberOfParticipants, :s_id
#note check that there is such a supervisor id available.
end
