class ChangeBirthdayType < ActiveRecord::Migration
  def self.up
    change_column("volunteers", "birthday", :date, :null => false, :default => Time.now )
  end

  def self.down
    change_column("volunteers", "birthday", :string, :limit => 30, :null => false)
  end
end
