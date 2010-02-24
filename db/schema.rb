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

ActiveRecord::Schema.define(:version => 20100224164912) do

  create_table "Administrator", :primary_key => "Aid", :force => true do |t|
    t.string "Name",      :null => false
    t.string "LoginName", :null => false
    t.string "Password",  :null => false
    t.string "Address",   :null => false
    t.string "PhoneNum"
    t.string "Email"
  end

  add_index "Administrator", ["LoginName"], :name => "LoginName", :unique => true

  create_table "Awarded", :primary_key => "AWid", :force => true do |t|
    t.integer "Rid", :null => false
    t.integer "Vid", :null => false
  end

  create_table "GroupProfiles", :primary_key => "Gid", :force => true do |t|
    t.string  "Name",                                :null => false
    t.integer "NumberOfParticipants", :default => 0, :null => false
    t.integer "VSid",                                :null => false
  end

  create_table "OrientationSession", :primary_key => "OSid", :force => true do |t|
    t.date   "Date",        :null => false
    t.string "Place",       :null => false
    t.string "Description"
  end

  create_table "Project", :primary_key => "Pid", :force => true do |t|
    t.string  "Name",        :null => false
    t.date    "StartDate",   :null => false
    t.date    "EndDate",     :null => false
    t.string  "Status",      :null => false
    t.string  "Description"
    t.integer "RPid",        :null => false
  end

  create_table "Reports", :primary_key => "REPid", :force => true do |t|
    t.string "ViewName", :null => false
  end

  create_table "RewardProfile", :primary_key => "RPid", :force => true do |t|
    t.string "Description"
    t.string "Name",        :null => false
  end

  add_index "RewardProfile", ["Name"], :name => "Name", :unique => true

  create_table "Rewards", :primary_key => "Rid", :force => true do |t|
    t.integer "RPid",        :null => false
    t.string  "Description"
    t.integer "Hours",       :null => false
  end

  create_table "Student", :primary_key => "v_id", :force => true do |t|
    t.integer "student_id"
    t.string  "faculty"
    t.string  "program"
    t.integer "year"
    t.date    "grad_date"
  end

  create_table "Supervises", :primary_key => "Pid", :force => true do |t|
    t.integer "VSid",      :null => false
    t.date    "StartDate", :null => false
    t.date    "EndDate",   :null => false
    t.string  "Status",    :null => false
  end

  add_index "Supervises", ["VSid"], :name => "VSid"

  create_table "VolunteerSupervisor", :primary_key => "VSid", :force => true do |t|
    t.string "Name",      :null => false
    t.string "loginName", :null => false
    t.string "Password",  :null => false
    t.string "Address",   :null => false
    t.string "PhoneNum"
    t.string "Email"
  end

  add_index "VolunteerSupervisor", ["loginName"], :name => "loginName", :unique => true

  create_table "orientation", :primary_key => "o_id", :force => true do |t|
    t.date   "start"
    t.date   "end"
    t.string "name"
    t.string "description"
    t.string "location"
  end

  create_table "orientation_project", :id => false, :force => true do |t|
    t.integer "p_id",     :default => 0, :null => false
    t.integer "o_id",     :default => 0, :null => false
    t.integer "priority"
  end

  add_index "orientation_project", ["o_id"], :name => "o_id"

  create_table "orientation_registration", :id => false, :force => true do |t|
    t.integer "v_id",     :default => 0, :null => false
    t.integer "o_id",     :default => 0, :null => false
    t.boolean "attended"
  end

  add_index "orientation_registration", ["o_id"], :name => "o_id"

  create_table "self_report", :primary_key => "r_id", :force => true do |t|
    t.integer "v_id"
    t.integer "p_id"
    t.integer "s_id"
    t.date    "date_reported"
    t.date    "start"
    t.date    "end"
    t.boolean "verified"
  end

  add_index "self_report", ["p_id"], :name => "p_id"
  add_index "self_report", ["s_id"], :name => "s_id"
  add_index "self_report", ["v_id"], :name => "v_id"

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
    t.string   "province",                  :limit => 20,  :null => false
    t.string   "postal_code",               :limit => 10,  :null => false
    t.boolean  "preferred_contact_method",                 :null => false
    t.string   "emrg_contact_name",         :limit => 60,  :null => false
    t.string   "emrg_contact_relationship", :limit => 30,  :null => false
    t.string   "emrg_contact_phone_work",   :limit => 20,  :null => false
    t.string   "emrg_contact_phone_home",   :limit => 20,  :null => false
    t.text     "special_consideration"
    t.text     "how_often_volunteer"
    t.text     "how_heard_about_farm"
    t.text     "why_volunteer"
    t.text     "skills"
    t.boolean  "first_aid",                                :null => false
    t.boolean  "foodsafe_level1",                          :null => false
    t.boolean  "foodsafe_level2",                          :null => false
    t.boolean  "own_transportation",                       :null => false
    t.text     "location",                  :limit => 255, :null => false
  end

end
