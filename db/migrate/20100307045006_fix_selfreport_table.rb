class FixSelfreportTable < ActiveRecord::Migration
  def self.up
    change_table :self_reports do |t|
      t.change      :volunteer_id,    :integer,   :null => false
      t.change      :supervisor_id,   :integer,   :null => false
      t.change      :project_id,      :integer,   :null => false
      t.rename      :start,           :start_time
      t.rename      :end,             :end_time
      t.change      :start_time,      :datetime,  :null => false
      t.change      :end_time,        :datetime,  :null => false
      t.change      :verified,        :integer,   :null => false, :default => 0, :limit => 1
      
      t.remove      :date_reported
      t.timestamps
    end
  end

  def self.down
    change_table :self_reports do |t|
      t.change      :volunteer_id,    :integer,   :null => true
      t.change      :supervisor_id,   :integer,   :null => true
      t.change      :project_id,      :integer,   :null => true
      t.rename      :start_time,      :start
      t.rename      :end_time,        :end
      t.change      :start,           :date,      :null => true
      t.change      :end,             :date,      :null => true
      t.change      :verified,        :integer,   :null => true, :default => 0, :limit => 1
      
      t.column      :date_reported,   :date
      t.remove      :created_at, :updated_at
    end
  end
end
