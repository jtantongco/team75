class Project < ActiveRecord::Base
  set_primary_key "p_id"
  has_many :self_reports
  has_many :project_feedbacks
  has_and_belongs_to_many :volunteers, :join_table => 'volunteers_projects'
end
