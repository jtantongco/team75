class ChangeActiveStatus < ActiveRecord::Migration
  def self.up
  	change_column("volunteers", "active_status", :boolean, :null => false, :default => 1)
  end

  def self.down
  	change_column("volunteers", "active_status", :integer, :null => false, :default => 1, :limit => 1)
  end
end
