class ChangeOrientationDates < ActiveRecord::Migration
  def self.up
  	rename_column(:orientations, :start, :start_time)
  	rename_column(:orientations, :end, :end_time)
  end

  def self.down
  	rename_column(:orientations, :start_time, :start)
  	rename_column(:orientations, :end_time, :end)
  end
end
