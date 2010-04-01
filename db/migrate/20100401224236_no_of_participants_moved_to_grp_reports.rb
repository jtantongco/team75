class NoOfParticipantsMovedToGrpReports < ActiveRecord::Migration
  def self.up
    remove_column  :group_profiles, :no_of_participants
    add_column     :group_reports,  :no_of_participants, :integer, :default => 0,     :null => false
  end

  def self.down
    remove_column :group_reports, :no_of_participants
    add_column    :group_profiles, :no_of_participants, :integer, :default => 0,     :null => false
  end
end
