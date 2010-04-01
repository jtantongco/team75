class CreateGroupReports < ActiveRecord::Migration
  def self.up
    create_table :group_reports do |t|
      t.int :gr_id
      t.int :g_id
      t.int :p_id
      t.time :start_time
      t.time :end_time
      t.date :date
      t.text :task_description

      t.timestamps
    end
  end

  def self.down
    drop_table :group_reports
  end
end
