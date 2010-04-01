class GroupProfilesModelFix < ActiveRecord::Migration
  def self.up
    change_table :group_profiles do |t|
      t.rename :gid, :g_id
      t.rename :Name, :name
      t.rename :NumberOfParticipants, :no_of_participants
      t.boolean :deleted, :default => false, :null => false
    end
    remove_column :group_profiles, :s_id
  end

  def self.down
    change_table :group_profiles do |t|
      t.rename  :g_id, :gid
      t.rename  :name, :Name
      t.rename  :no_of_participants, :NumberOfParticipants
    end
    remove_column :deleted
    add_column :group_profiles, :s_id, :integer, :null => false
  end
end
