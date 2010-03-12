class Supervisor < ActiveRecord::Base
  set_primary_key "s_id"
  has_many :self_reports
end
