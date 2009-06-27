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

ActiveRecord::Schema.define(:version => 20090627185801) do

  create_table "domains", :force => true do |t|
    t.integer  "organisation_id", :default => 0,  :null => false
    t.string   "name",            :default => "", :null => false
    t.integer  "web_host_id",     :default => 0,  :null => false
    t.integer  "forwarding_id"
    t.date     "registered_on",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisations", :force => true do |t|
    t.string   "name",           :default => "", :null => false
    t.datetime "last_contacted",                 :null => false
    t.integer  "contact_cycle",  :default => 90, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                 :default => "",    :null => false
    t.string   "name",                  :default => "",    :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",                 :default => false, :null => false
    t.string   "forgot_password_token", :default => "",    :null => false
    t.integer  "organisation_id",       :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
