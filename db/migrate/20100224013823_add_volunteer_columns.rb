class AddVolunteerColumns < ActiveRecord::Migration
  def self.up
    add_column  :volunteers, :birthday,                               :string, :null => false, :limit => 30
    add_column  :volunteers, :phone_home,                             :string, :null => true, :limit => 20
    add_column  :volunteers, :phone_work,                             :string, :null => true, :limit => 20
    add_column  :volunteers, :phone_cell,                             :string, :null => true, :limit => 20
    add_column  :volunteers, :address,                                :string, :null => false, :limit => 50
    add_column  :volunteers, :province,                               :string, :null => false, :limit => 20
    add_column  :volunteers, :postal_code,                            :string, :null => false, :limit => 10
    add_column  :volunteers, :preferred_contact_method,               :boolean, :null => false
    add_column  :volunteers, :emrg_contact_name,                      :string, :null => false, :limit => 60
    add_column  :volunteers, :emrg_contact_relationship,              :string, :null => false, :limit => 30
    add_column  :volunteers, :emrg_contact_phone_work,                :string, :null => false, :limit => 20
    add_column  :volunteers, :emrg_contact_phone_home,                :string, :null => false, :limit => 20
    add_column  :volunteers, :special_consideration,                  :text, :null => true
    add_column  :volunteers, :how_often_volunteer,                    :text, :null => true
    add_column  :volunteers, :how_heard_about_farm,                   :text, :null => true
    add_column  :volunteers, :why_volunteer,                          :text, :null => true
    add_column  :volunteers, :skills,                                 :text, :null => true
    add_column  :volunteers, :first_aid,                              :boolean, :null => false
    add_column  :volunteers, :foodsafe_level1,                        :boolean, :null => false
    add_column  :volunteers, :foodsafe_level2,                        :boolean, :null => false
    add_column  :volunteers, :own_transportation,                     :boolean, :null => false
  end

  def self.down
    remove_column :volunteers, :birthday, :phone_home, :phone_work, :phone_cell, :address, :province, :postal_code
    remove_column :volunteers, :preferred_contact_method, :emrg_contact_name, :emrg_contact_relationship
    remove_column :volunteers, :special_consideration, :how_often_volunteer, :how_heard_about_farm
    remove_column :volunteers, :why_volunteer, :skills, :first_aid, :foodsafe_level1, :foodsafe_level2, :own_transportation
  end
end
