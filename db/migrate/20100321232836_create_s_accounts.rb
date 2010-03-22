class CreateSAccounts < ActiveRecord::Migration
  def self.up
    create_table :s_accounts do |t|
      t.int :s_id
      t.string :name
      t.string :login_name
      t.string :password
      t.text :address
      t.text :phone_num
      t.text :email

      t.timestamps
    end
  end

  def self.down
    drop_table :s_accounts
  end
end
