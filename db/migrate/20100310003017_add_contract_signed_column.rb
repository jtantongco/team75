class AddContractSignedColumn < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :contract_signed, :boolean, :default => false
  end

  def self.down
    remove_column :volunteers, :contract_signed
  end
end
