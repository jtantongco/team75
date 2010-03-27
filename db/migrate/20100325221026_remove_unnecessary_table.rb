class RemoveUnnecessaryTable < ActiveRecord::Migration
  def self.up
    drop_table :volunteer_project_interests
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't recover the table"
  end
end
