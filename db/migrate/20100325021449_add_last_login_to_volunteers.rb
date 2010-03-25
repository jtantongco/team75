class AddLastLoginToVolunteers < ActiveRecord::Migration
  def self.up
	add_column :volunteers, :last_login, :datetime, :default => Time.now, :null => false
  end

  def self.down
	remove_column :volunteers, :last_login
  end
end
