class RewardProfile < ActiveRecord::Base
  set_primary_key "RPid"
  
  #has_many :rewards
  
  validates_presence_of :name
end
