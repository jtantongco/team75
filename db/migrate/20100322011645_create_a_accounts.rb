class CreateAAccounts < ActiveRecord::Migration
  def self.up
    create_table :a_accounts do |t|
      t.int :aid
      t.string :name
      t.string :loginname
      t.string :password
      t.text :address
      t.text :phonenum
      t.textext :email

      t.timestamps
    end
  end

  def self.down
    drop_table :a_accounts
  end
end
