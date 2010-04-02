class GroupProfile < ActiveRecord::Base
  set_primary_key "g_id"

  validates_presence_of :name, :no_of_participants
  validates_numericality_of :no_of_participants
end
