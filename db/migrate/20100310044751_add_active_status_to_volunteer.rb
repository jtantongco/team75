class AddActiveStatusToVolunteer < ActiveRecord::Migration
  def self.up
  	add_column :volunteers, :active_status, :integer, :null => false, :default => 1, :limit => 1
  end

  def self.down
  	remove_column :volunteers, :active_status
  end
end
