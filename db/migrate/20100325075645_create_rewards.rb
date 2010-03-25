class CreateRewards < ActiveRecord::Migration
  def self.up
    create_table :rewards do |t|
      t.int :Rid
      t.int :RPid
      t.string :Name
      t.string :Description
      t.int :Hours

      t.timestamps
    end
  end

  def self.down
    drop_table :rewards
  end
end
