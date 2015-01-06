# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150106133836) do

  create_table "addresses", force: true do |t|
    t.integer  "organisation_id", default: 0,  null: false
    t.string   "address_line_1",  default: "", null: false
    t.string   "address_line_2",  default: "", null: false
    t.string   "town_city",       default: "", null: false
    t.string   "county",          default: "", null: false
    t.string   "postcode",        default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["organisation_id"], name: "index_addresses_on_organisation_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "issue_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["issue_id"], name: "index_comments_on_issue_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "databases", force: true do |t|
    t.string   "host"
    t.string   "name"
    t.string   "username"
    t.string   "password"
    t.integer  "organisation_id"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "databases", ["organisation_id"], name: "index_databases_on_organisation_id", using: :btree

  create_table "domains", force: true do |t|
    t.integer  "organisation_id", default: 0,    null: false
    t.string   "name",            default: "",   null: false
    t.integer  "forwarding_id"
    t.date     "registered_on",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "with_us",         default: true, null: false
  end

  add_index "domains", ["organisation_id"], name: "index_domains_on_organisation_id", using: :btree

  create_table "email_addresses", force: true do |t|
    t.integer  "organisation_id"
    t.integer  "user_id"
    t.string   "address",         default: "", null: false
    t.string   "password",        default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "email_addresses", ["organisation_id"], name: "index_email_addresses_on_organisation_id", using: :btree
  add_index "email_addresses", ["user_id"], name: "index_email_addresses_on_user_id", using: :btree

  create_table "hosting_accounts", force: true do |t|
    t.integer  "domain_id",                                         default: 0,      null: false
    t.string   "ftp_host",                                          default: "",     null: false
    t.string   "username",                                          default: "",     null: false
    t.string   "password",                                          default: "",     null: false
    t.date     "started_on",                                                         null: false
    t.string   "host_name",                                         default: "",     null: false
    t.date     "backed_up_on",                                                       null: false
    t.integer  "backup_cycle",                                      default: 14,     null: false
    t.decimal  "annual_fee",                precision: 6, scale: 2, default: 0.0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "expected_http_status_code",                         default: "200",  null: false
    t.string   "scheme",                                            default: "http", null: false
    t.integer  "port",                                              default: 80,     null: false
    t.boolean  "maintained",                                        default: true,   null: false
  end

  add_index "hosting_accounts", ["domain_id"], name: "index_hosting_accounts_on_domain_id", using: :btree

  create_table "issues", force: true do |t|
    t.integer  "organisation_id",                                          null: false
    t.integer  "setter_id",                                                null: false
    t.integer  "assignee_id",                                              null: false
    t.integer  "priority",                                 default: 3,     null: false
    t.date     "date_due"
    t.boolean  "completed",                                default: false, null: false
    t.string   "title",                                                    null: false
    t.text     "details"
    t.integer  "estimated_time"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.decimal  "estimated_price", precision: 10, scale: 2, default: 0.0,   null: false
  end

  create_table "note_pads", force: true do |t|
    t.integer  "organisation_id", default: 0,  null: false
    t.string   "title",           default: "", null: false
    t.text     "content",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "note_pads", ["organisation_id"], name: "index_note_pads_on_organisation_id", using: :btree

  create_table "numbers", force: true do |t|
    t.integer  "organisation_id"
    t.integer  "user_id"
    t.string   "teltype",         default: "tel", null: false
    t.string   "note",            default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number",          default: "",    null: false
  end

  add_index "numbers", ["organisation_id"], name: "index_numbers_on_organisation_id", using: :btree
  add_index "numbers", ["user_id"], name: "index_numbers_on_user_id", using: :btree

  create_table "organisation_watchers", force: true do |t|
    t.integer  "organisation_id", null: false
    t.integer  "user_id",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organisation_watchers", ["organisation_id"], name: "index_organisation_watchers_on_organisation_id", using: :btree
  add_index "organisation_watchers", ["user_id"], name: "index_organisation_watchers_on_user_id", using: :btree

  create_table "organisations", force: true do |t|
    t.string   "name",           default: "",    null: false
    t.datetime "last_contacted",                 null: false
    t.integer  "contact_cycle",  default: 90,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_viewed_at"
    t.boolean  "on_stop",        default: false, null: false
    t.boolean  "archived",       default: false, null: false
  end

  add_index "organisations", ["last_viewed_at"], name: "index_organisations_on_last_viewed_at", using: :btree
  add_index "organisations", ["updated_at"], name: "index_organisations_on_updated_at", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "timesheet_entries", force: true do |t|
    t.integer  "organisation_id",                          default: 0,     null: false
    t.integer  "user_id",                                  default: 0,     null: false
    t.text     "description",                                              null: false
    t.decimal  "invoice_value",   precision: 10, scale: 2, default: 0.0,   null: false
    t.boolean  "chargeable",                               default: false, null: false
    t.integer  "minutes",                                  default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at",                                               null: false
  end

  add_index "timesheet_entries", ["organisation_id"], name: "index_timesheet_entries_on_organisation_id", using: :btree
  add_index "timesheet_entries", ["started_at"], name: "index_timesheet_entries_on_started_at", using: :btree
  add_index "timesheet_entries", ["user_id"], name: "index_timesheet_entries_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                 default: "",    null: false
    t.string   "name",                  default: "",    null: false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",                 default: false, null: false
    t.string   "forgot_password_token", default: "",    null: false
    t.integer  "organisation_id",       default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "staff",                 default: false, null: false
  end

  add_index "users", ["staff"], name: "index_users_on_staff", using: :btree
  add_index "users", ["updated_at"], name: "index_users_on_updated_at", using: :btree

end
