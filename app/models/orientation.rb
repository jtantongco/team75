class Orientation < ActiveRecord::Base
  set_primary_key "o_id"
	
  belongs_to :orientation_project
  
  validates_presence_of :start_time, :end_time, :name, :location
  validate :dates_are_not_in_the_future, :end_date_is_after_start_date
  
  def dates_are_not_in_the_future
    errors.add(:start_time, "can't be in the future")   if start_time  > Time.now
    errors.add(:end_time, "can't be in the future")     if end_time    > Time.now
  end
  
  def end_date_is_after_start_date
    errors.add(:end_time, "can't be before start time") if start_time  > end_time
  end
end
