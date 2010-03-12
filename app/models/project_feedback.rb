class ProjectFeedback < ActiveRecord::Base
  set_primary_key 'f_id'
  belongs_to :volunteer
  belongs_to :project
  
  validates_presence_of :feedback
end
