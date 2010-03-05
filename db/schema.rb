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

ActiveRecord::Schema.define(:version => 20100304225839) do

  create_table "administrators", :primary_key => "Aid", :force => true do |t|
    t.string "Name",      :null => false
    t.string "LoginName", :null => false
    t.string "Password",  :null => false
    t.string "Address",   :null => false
    t.string "PhoneNum"
    t.string "Email"
  end

  add_index "administrators", ["LoginName"], :name => "LoginName", :unique => true

  create_table "awarded_profiles", :primary_key => "AWid", :force => true do |t|
    t.integer "Rid", :null => false
    t.integer "Vid", :null => false
  end

  create_table "group_profiles", :primary_key => "Gid", :force => true do |t|
    t.string  "Name",                                :null => false
    t.integer "NumberOfParticipants", :default => 0, :null => false
    t.integer "VSid",                                :null => false
  end

  create_table "orientations", :primary_key => "o_id", :force => true do |t|
    t.date   "start"
    t.date   "end"
    t.string "name"
    t.string "description"
    t.string "location"
  end

  create_table "orientations_projects", :id => false, :force => true do |t|
    t.integer "project_id",     :default => 0, :null => false
    t.integer "orientation_id", :default => 0, :null => false
    t.integer "priority"
  end

  add_index "orientations_projects", ["orientation_id"], :name => "o_id"

  create_table "projects", :primary_key => "Pid", :force => true do |t|
    t.string  "Name",        :null => false
    t.date    "StartDate",   :null => false
    t.date    "EndDate",     :null => false
    t.string  "Status",      :null => false
    t.string  "Description"
    t.integer "RPid",        :null => false
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

  create_table "schema_info", :id => false, :force => true do |t|
    t.integer "version"
  end

  create_table "self_reports", :primary_key => "r_id", :force => true do |t|
    t.integer "volunteer_id"
    t.integer "project_id"
    t.integer "supervisor_id"
    t.date    "date_reported"
    t.date    "start"
    t.date    "end"
    t.boolean "verified"
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
    t.integer "VSid",      :null => false
    t.date    "StartDate", :null => false
    t.date    "EndDate",   :null => false
    t.string  "Status",    :null => false
  end

  add_index "supervises", ["VSid"], :name => "VSid"

  create_table "supervisors", :primary_key => "VSid", :force => true do |t|
    t.string "Name",      :null => false
    t.string "loginName", :null => false
    t.string "Password",  :null => false
    t.string "Address",   :null => false
    t.string "PhoneNum"
    t.string "Email"
  end

  add_index "supervisors", ["loginName"], :name => "loginName", :unique => true

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
    t.string   "first_name",                               :null => false
    t.string   "last_name",                                :null => false
    t.string   "email",                                    :null => false
    t.string   "password",                                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birthday",                                 :null => false
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

  create_table "volunteers_orientations", :id => false, :force => true do |t|
    t.integer "volunteer_id",   :default => 0, :null => false
    t.integer "orientation_id", :default => 0, :null => false
    t.boolean "attended"
  end

  add_index "volunteers_orientations", ["orientation_id"], :name => "o_id"

  create_table "volunteers_projects", :id => false, :force => true do |t|
    t.integer "volunteer_id", :default => 0, :null => false
    t.integer "project_id",   :default => 0, :null => false
  end

end
