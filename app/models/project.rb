class Project < ActiveRecord::Base
  set_primary_key "p_id"
  has_many :self_reports
end
