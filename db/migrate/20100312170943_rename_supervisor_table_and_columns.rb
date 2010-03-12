class RenameSupervisorTableAndColumns < ActiveRecord::Migration
  def self.up
    rename_table :VolunteerSupervisor, :supervisors
    change_table :supervisors do |t|
      t.rename :VSid,       :s_id
      t.rename :Name,       :name
      t.rename :loginName,  :login_name
      t.rename :Password,   :password
      t.rename :Address,    :address
      t.rename :PhoneNum,   :phone_num
      t.rename :Email,      :email
    end
  end

  def self.down
    change_table :supervisors do |t|
      t.rename :s_id,       :VSid
      t.rename :name,       :Name
      t.rename :login_name, :loginName
      t.rename :password,   :Password
      t.rename :address,    :Address
      t.rename :phone_num,  :PhoneNum
      t.rename :email,      :Email
    end
    rename_table :supervisors, :VolunteerSupervisor
  end
end
