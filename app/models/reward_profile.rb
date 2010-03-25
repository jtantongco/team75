class RewardProfile < ActiveRecord::Base
  set_primary_key "RPid"
   
  validates_presence_of :name
end
