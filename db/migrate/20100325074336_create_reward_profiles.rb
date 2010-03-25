class CreateRewardProfiles < ActiveRecord::Migration
  def self.up
    create_table :reward_profiles do |t|
      t.int :RPid
      t.string :Description
      t.string :Name

      t.timestamps
    end
  end

  def self.down
    drop_table :reward_profiles
  end
end
