class RenameProjectTableAndColumns < ActiveRecord::Migration
  def self.up
    rename_table :Project, :projects
    change_table :projects do |t|
      t.rename :Pid, :p_id
      t.rename :Name, :name
      t.rename :StartDate, :start_date
      t.rename :EndDate, :end_date
      t.rename :Status, :status
      t.rename :Description, :description
      t.rename :RPid, :rewardprofile_id
    end
  end

  def self.down
    change_table :projects do |t|
      t.rename :p_id, :Pid
      t.rename :name, :Name
      t.rename :start_date, :StartDate
      t.rename :end_date, :EndDate
      t.rename :status, :Status
      t.rename :description, :Description
      t.rename :rewardprofile_id, :RPid
    end
    rename_table :projects, :Project
  end
end
