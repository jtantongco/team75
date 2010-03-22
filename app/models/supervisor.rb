class Supervisor < ActiveRecord::Base
  set_primary_key "s_id"
  
  has_many :self_reports
  
  validates_presence_of :name, :login_name, :password, :address,
    :phone_num, :email
  
  validates_confirmation_of :password
end
