class GroupReport < ActiveRecord::Base
	set_primary_key "gr_id"
  #belongs_to :
  belongs_to :project
  belongs_to :supervisor
  
  validates_presence_of :g_id, :p_id, :s_id, :date, :start_time, :end_time
	
	
end
