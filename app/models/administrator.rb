class Administrator < ActiveRecord::Base
  set_primary_key "a_id"
   
  validates_presence_of :name, :login_name, :password, :address,
    :phone_num, :email
  
  validates_confirmation_of :password
end
