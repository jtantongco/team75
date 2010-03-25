# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100325021449) do

  create_table "a_accounts", :force => true do |t|
    t.string   "name"
    t.string   "loginname"
    t.string   "password"
    t.text     "address"
    t.text     "phonenum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administrators", :primary_key => "a_id", :force => true do |t|
    t.string "name",       :null => false
    t.string "login_name", :null => false
    t.string "password",   :null => false
    t.string "address",    :null => false
    t.string "phone_num"
    t.string "email"
  end

  add_index "administrators", ["login_name"], :name => "LoginName", :unique => true

  create_table "awarded_profiles", :primary_key => "AWid", :force => true do |t|
    t.integer "Rid", :null => false
    t.integer "Vid", :null => false
  end

  create_table "email_profile", :id => false, :force => true do |t|
    t.string "Email", :limit => 50
  end

  create_table "group_profiles", :primary_key => "Gid", :force => true do |t|
    t.string  "Name",                                :null => false
    t.integer "NumberOfParticipants", :default => 0, :null => false
    t.integer "s_id",                                :null => false
  end

  create_table "orientations", :primary_key => "o_id", :force => true do |t|
    t.datetime "start_time",  :null => false
    t.datetime "end_time",    :null => false
    t.string   "name"
    t.string   "description"
    t.string   "location"
  end

  create_table "project_feedbacks", :primary_key => "f_id", :force => true do |t|
    t.integer  "project_id",   :null => false
    t.integer  "volunteer_id", :null => false
    t.string   "feedback",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_orientations", :id => false, :force => true do |t|
    t.integer "project_id",     :default => 0, :null => false
    t.integer "orientation_id", :default => 0, :null => false
    t.integer "priority"
  end

  add_index "project_orientations", ["orientation_id"], :name => "o_id"

  create_table "projects", :primary_key => "p_id", :force => true do |t|
    t.string  "name",             :null => false
    t.date    "start_date",       :null => false
    t.date    "end_date",         :null => false
    t.string  "status",           :null => false
    t.string  "description"
    t.integer "rewardprofile_id", :null => false
    t.integer "s_id"
  end

  create_table "reports", :primary_key => "REPid", :force => true do |t|
    t.string "ViewName", :null => false
  end

  create_table "reward_profiles", :primary_key => "RPid", :force => true do |t|
    t.string "Description"
    t.string "Name",        :null => false
  end

  add_index "reward_profiles", ["Name"], :name => "Name", :unique => true

  create_table "rewards", :primary_key => "Rid", :force => true do |t|
    t.integer "RPid",        :null => false
    t.string  "Description"
    t.integer "Hours",       :null => false
  end

  create_table "s_accounts", :force => true do |t|
    t.string   "name"
    t.string   "login_name"
    t.string   "password"
    t.text     "address"
    t.text     "phone_num"
    t.text     "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schema_info", :id => false, :force => true do |t|
    t.integer "version"
  end

  create_table "self_reports", :primary_key => "r_id", :force => true do |t|
    t.integer  "volunteer_id",                        :null => false
    t.integer  "project_id",                          :null => false
    t.integer  "supervisor_id",                       :null => false
    t.time     "start_time",                          :null => false
    t.time     "end_time",                            :null => false
    t.boolean  "verified",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.string   "task_description",                    :null => false
  end

  add_index "self_reports", ["project_id"], :name => "p_id"
  add_index "self_reports", ["supervisor_id"], :name => "s_id"
  add_index "self_reports", ["volunteer_id"], :name => "v_id"

  create_table "students", :primary_key => "volunteer_id", :force => true do |t|
    t.integer "student_id"
    t.string  "faculty"
    t.string  "program"
    t.integer "year"
    t.date    "grad_date"
  end

  create_table "supervises", :primary_key => "Pid", :force => true do |t|
    t.integer "s_id",      :null => false
    t.date    "StartDate", :null => false
    t.date    "EndDate",   :null => false
    t.string  "Status",    :null => false
  end

  add_index "supervises", ["s_id"], :name => "VSid"

  create_table "supervisors", :primary_key => "s_id", :force => true do |t|
    t.string "name",       :null => false
    t.string "login_name", :null => false
    t.string "password",   :null => false
    t.string "address",    :null => false
    t.string "phone_num"
    t.string "email"
  end

  add_index "supervisors", ["login_name"], :name => "loginName", :unique => true

  create_table "volunteer_extras", :primary_key => "volunteer_id", :force => true do |t|
    t.text    "how_often_volunteer"
    t.text    "how_heard_about_farm"
    t.text    "why_volunteer"
    t.text    "skills_and_knowledge"
    t.boolean "first_aid",            :null => false
    t.boolean "foodsafe_level1",      :null => false
    t.boolean "foodsafe_level2",      :null => false
    t.boolean "own_transportation",   :null => false
    t.boolean "skill_farming",        :null => false
    t.boolean "skill_construction",   :null => false
    t.boolean "skill_sales",          :null => false
    t.boolean "skill_fundraising",    :null => false
    t.boolean "skill_music",          :null => false
    t.boolean "skill_art",            :null => false
    t.boolean "skill_computer",       :null => false
  end

  create_table "volunteer_project_interests", :id => false, :force => true do |t|
    t.integer "volunteer_id", :default => 0, :null => false
    t.integer "project_id",   :default => 0, :null => false
  end

  create_table "volunteers", :primary_key => "v_id", :force => true do |t|
    t.string   "first_name",                                                                  :null => false
    t.string   "last_name",                                                                   :null => false
    t.string   "email",                                                                       :null => false
    t.string   "password",                                                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birthday",                                                                    :null => false
    t.string   "phone_home",                :limit => 20
    t.string   "phone_work",                :limit => 20
    t.string   "phone_cell",                :limit => 20
    t.string   "address",                   :limit => 50,                                     :null => false
    t.text     "location",                  :limit => 255,                                    :null => false
    t.string   "province",                  :limit => 20,                                     :null => false
    t.string   "postal_code",               :limit => 10,                                     :null => false
    t.boolean  "preferred_contact_method",                                                    :null => false
    t.string   "emrg_contact_name",         :limit => 60,                                     :null => false
    t.string   "emrg_contact_relationship", :limit => 30,                                     :null => false
    t.string   "emrg_contact_phone_work",   :limit => 20,                                     :null => false
    t.string   "emrg_contact_phone_home",   :limit => 20,                                     :null => false
    t.text     "special_consideration"
    t.boolean  "activated"
    t.string   "activation_code"
    t.boolean  "contract_signed",                          :default => false
    t.boolean  "active_status",                            :default => true,                  :null => false
    t.datetime "last_login",                               :default => '2010-03-24 19:16:38', :null => false
  end

  create_table "volunteers_orientations", :id => false, :force => true do |t|
    t.integer "volunteer_id",   :default => 0, :null => false
    t.integer "orientation_id", :default => 0, :null => false
    t.boolean "attended"
  end

  add_index "volunteers_orientations", ["orientation_id", "volunteer_id"], :name => "volunteers_orientations_index", :unique => true
  add_index "volunteers_orientations", ["orientation_id"], :name => "o_id"

  create_table "volunteers_projects", :id => false, :force => true do |t|
    t.integer "volunteer_id", :default => 0, :null => false
    t.integer "project_id",   :default => 0, :null => false
  end

end
