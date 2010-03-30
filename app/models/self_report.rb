class SelfReport < ActiveRecord::Base
  set_primary_key "r_id"
  belongs_to :volunteer
  belongs_to :project
  belongs_to :supervisor
  
  validates_presence_of :project_id, :supervisor_id, :date, :start_time, :end_time
  validate :dates_are_not_in_the_future, :end_date_is_after_start_date, :project_exists, :supervisor_exists

  # Checks that the volunteer doesn't try to report hours for the future
  def dates_are_not_in_the_future
    start_date  =  Time.parse(date.to_s + " " + start_time.hour.to_s + ":" + start_time.min.to_s)
    end_date  =  Time.parse(date.to_s + " " + end_time.hour.to_s + ":" + end_time.min.to_s)

    errors.add(:start_time, "can't be in the future")   if start_date  > Time.now
    errors.add(:end_time, "can't be in the future")     if end_date    > Time.now
  end
  
  # Checks that the chosen end time is after the chosen start time
  def end_date_is_after_start_date
    start_date  =  Time.parse(date.to_s + " " + start_time.hour.to_s + ":" + start_time.min.to_s)
    end_date  =  Time.parse(date.to_s + " " + end_time.hour.to_s + ":" + end_time.min.to_s)

    errors.add(:end_time, "must be after start time") if start_date  >= end_date
  end

  # Checks if the chosen project exists
  def project_exists
    errors.add(:project_id, 'does not exist.') if !Project.exists?(project_id)
  end

  # Checks if the chosen supervisor exists
  def supervisor_exists
    errors.add(:supervisor_id, 'does not exist.') if !Supervisor.exists?(supervisor_id)
  end

  # Calculates and returns the number of hours and minutes of the report
  # Output is on the form "X h Y min"
  def hours
    total = (end_time - start_time) / 1.hour
    hours = total.floor
    minutes = (total - hours).minutes.round
    if minutes > 0
      "#{hours} h #{minutes.to_s.ljust(2, 0.to_s)} min"
    else
      "#{hours} h"
    end
  end
end
