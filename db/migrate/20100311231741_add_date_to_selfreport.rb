class AddDateToSelfreport < ActiveRecord::Migration
  def self.up
    add_column :self_reports, :date, :date
    change_column :self_reports, :start_time, :time
    change_column :self_reports, :end_time, :time
  end

  def self.down
    change_column :self_reports, :end_time, :datetime
    change_column :self_reports, :start_time, :datetime
    remove_column :self_reports, :date
  end
end
