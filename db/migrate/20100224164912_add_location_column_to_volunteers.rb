class AddLocationColumnToVolunteers < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :location, :text, :limit => 50, :null => false
  end

  def self.down
    remove_column :volunteers, :location
  end
end
