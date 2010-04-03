class Project < ActiveRecord::Base

set_primary_key "p_id"

#has_many :supervises
#has_many :self_reports
#has_many:projects

validates_presence_of :name, :start_date, :end_date, :status, :rewardprofile_id



validates_uniqueness_of :name,
   :message => 'address has already been used'
end