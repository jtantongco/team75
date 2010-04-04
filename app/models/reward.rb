class Reward < ActiveRecord::Base
  set_primary_key "Rid"
  
  #belongs_to :reward_profile
  
  validates_presence_of :Name, :Hours
end
