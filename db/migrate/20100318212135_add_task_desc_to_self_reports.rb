class AddTaskDescToSelfReports < ActiveRecord::Migration
  def self.up
    add_column :self_reports, :task_description, :string, :null => false
  end

  def self.down
    remove_column :self_reports, :task_description
  end
end
