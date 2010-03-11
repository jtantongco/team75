class ChangeOrientationDateToDatetime < ActiveRecord::Migration
  def self.up
  	change_column("orientations", "start_time", :datetime, :null => false)
  	change_column("orientations", "end_time", :datetime, :null => false)
  end

  def self.down
  	change_column("orientations", "start_time", :date, :null => false)
  	change_column("orientations", "end_time", :date, :null => false)
  end
end
