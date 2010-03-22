class BatchCreateVolunteerTables < ActiveRecord::Migration
  def self.up
    create_table "volunteers", :primary_key => "v_id", :force => true do |t|
      t.string   "first_name",                               :null => false
      t.string   "last_name",                                :null => false
      t.string   "email",                                    :null => false
      t.string   "password",                                 :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "birthday",                  :limit => 30,  :null => false
      t.string   "phone_home",                :limit => 20
      t.string   "phone_work",                :limit => 20
      t.string   "phone_cell",                :limit => 20
      t.string   "address",                   :limit => 50,  :null => false
      t.text     "location",                  :limit => 255, :null => false
      t.string   "province",                  :limit => 20,  :null => false
      t.string   "postal_code",               :limit => 10,  :null => false
      t.boolean  "preferred_contact_method",                 :null => false
      t.string   "emrg_contact_name",         :limit => 60,  :null => false
      t.string   "emrg_contact_relationship", :limit => 30,  :null => false
      t.string   "emrg_contact_phone_work",   :limit => 20,  :null => false
      t.string   "emrg_contact_phone_home",   :limit => 20,  :null => false
      t.text     "special_consideration"
      t.boolean  "activated"
    end
    
    
    create_table "volunteer_extras", :primary_key => "v_id", :force => true do |t|
      t.text     "how_often_volunteer"
      t.text     "how_heard_about_farm"
      t.text     "why_volunteer"
      t.text     "skills_and_knowledge"
      t.boolean  "first_aid",                                :null => false
      t.boolean  "foodsafe_level1",                          :null => false
      t.boolean  "foodsafe_level2",                          :null => false
      t.boolean  "own_transportation",                       :null => false
      t.boolean  "skill_farming",                            :null => false
      t.boolean  "skill_construction",                       :null => false
      t.boolean  "skill_sales",                              :null => false
      t.boolean  "skill_fundraising",                        :null => false
      t.boolean  "skill_music",                              :null => false
      t.boolean  "skill_art",                                :null => false
      t.boolean  "skill_computer",                           :null => false
    end

    create_table "students", :primary_key => "v_id", :force => true do |t|
      t.integer "student_id"
      t.string  "faculty"
      t.string  "program"
      t.integer "year"
      t.date    "grad_date"
    end
    
    create_table "volunteer_projects", :id => false, :force => true do |t|
      t.integer "v_id",     :default => 0, :null => false
      t.integer "p_id",     :default => 0, :null => false
    end

    create_table "volunteer_project_interests", :id => false, :force => true do |t|
      t.integer "v_id",     :default => 0, :null => false
      t.integer "p_id",     :default => 0, :null => false
    end

    create_table "orientations", :primary_key => "o_id", :force => true do |t|
      t.date   "start"
      t.date   "end"
      t.string "name"
      t.string "description"
      t.string "location"
    end

    create_table "orientation_projects", :id => false, :force => true do |t|
      t.integer "p_id",     :default => 0, :null => false
      t.integer "o_id",     :default => 0, :null => false
      t.integer "priority"
    end

    add_index "orientation_projects", ["o_id"], :name => "o_id"

    create_table "orientation_registrations", :id => false, :force => true do |t|
      t.integer "v_id",     :default => 0, :null => false
      t.integer "o_id",     :default => 0, :null => false
      t.boolean "attended"
    end

    add_index "orientation_registrations", ["o_id"], :name => "o_id"

    create_table "self_reports", :primary_key => "r_id", :force => true do |t|
      t.integer "v_id"
      t.integer "p_id"
      t.integer "s_id"
      t.date    "date_reported"
      t.date    "start"
      t.date    "end"
      t.boolean "verified"
    end

    add_index "self_reports", ["p_id"], :name => "p_id"
    add_index "self_reports", ["s_id"], :name => "s_id"
    add_index "self_reports", ["v_id"], :name => "v_id"
  end

  def self.down
    drop_table  :volunteer_extras
    drop_table  :students
    drop_table  :volunteer_projects
    drop_table  :volunteer_project_interests
    drop_table  :orientations
    drop_table  :orientation_projects
    drop_table  :orientation_registrations
    drop_table  :self_reports
    drop_table  :volunteers
  end
end
