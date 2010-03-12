class ChangeTypeOfSelfreportVerifiedColumn < ActiveRecord::Migration
  def self.up
    change_column :self_reports, :verified, :boolean, :default => false
  end

  def self.down
    change_column :self_reports, :verified, :integer, :limit => 1, :default => 0
  end
end
