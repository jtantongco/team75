class SelfReport < ActiveRecord::Base
  set_primary_key "r_id"
  belongs_to :volunteer
  belongs_to :project
  belongs_to :supervisor
  
  validates_presence_of :project_id, :supervisor_id, :start_time, :end_time
  validate :dates_are_not_in_the_future, :end_date_is_after_start_date
  
  def dates_are_not_in_the_future
    start_date  =  Time.parse(date.to_s + " " + start_time.hour.to_s + ":" + start_time.min.to_s)
    end_date  =  Time.parse(date.to_s + " " + end_time.hour.to_s + ":" + end_time.min.to_s)

    errors.add(:start_time, "can't be in the future")   if start_date  > Time.now
    errors.add(:end_time, "can't be in the future")     if end_date    > Time.now
  end
  
  def end_date_is_after_start_date
    errors.add(:end_time, "can't be before start time") if start_time  > end_time
  end
  
  def hours
    total = (end_time - start_time) / 1.hour
    hours = total.floor
    minutes = (total - hours).minutes.round
    "#{hours}:#{minutes.to_s.ljust(2, 0.to_s)}"
  end
  
  # todo: Remove these when project and supervisor models are created
  def project
    project_id
  end
  
  def supervisor
    supervisor_id
  end
end
