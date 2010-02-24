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

ActiveRecord::Schema.define(:version => 20100222234907) do

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

  create_table "volunteers", :primary_key => "v_id", :force => true do |t|
    t.string   "first_name", :null => false
    t.string   "last_name",  :null => false
    t.string   "email",      :null => false
    t.string   "password",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
  create_table "student", :primary_key => "v_id", :force => true do |t|
    t.integer  "student_id", :null => false
    t.integer  "year",       :null => false
    t.string   "faculty",    :null => false
    t.string   "program",    :null => false
	t.date	   "grad_date"   :null => false
  end
  
  add_index "student", ["v_id"], :name => "v_id"
  
  create_table "orientation", :primary_key => "o_id", :force => true do |t|
    t.string   "name",           :null => false
    t.string   "description",    :null => false
    t.string   "location",       :null => false
	t.date	   "start"           :null => false
	t.date	   "end"             :null => false
  end
  
end
