class SelfReport < ActiveRecord::Base
  set_primary_key "r_id"
  belongs_to :volunteer
  belongs_to :project
  belongs_to :supervisor
  
  validates_presence_of :project_id, :supervisor_id, :start_time, :end_time
  validate :dates_are_not_in_the_future, :end_date_is_after_start_date
  
  def dates_are_not_in_the_future
    errors.add(:start_time, "can't be in the future")   if start_time  > Time.now
    errors.add(:end_time, "can't be in the future")     if end_time    > Time.now
  end
  
  def end_date_is_after_start_date
    errors.add(:end_time, "can't be before start time") if start_time  > end_time
  end
end
