class DropOrganisationWatchers < ActiveRecord::Migration
  def up
    create_table "addresses", force: :cascade do |t|
      t.integer  "organisation_id", limit: 4,   default: 0,  null: false
      t.string   "address_line_1",  limit: 255, default: "", null: false
      t.string   "address_line_2",  limit: 255, default: "", null: false
      t.string   "town_city",       limit: 255, default: "", null: false
      t.string   "county",          limit: 255, default: "", null: false
      t.string   "postcode",        limit: 255, default: "", null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "addresses", ["organisation_id"], name: "index_addresses_on_organisation_id", using: :btree

    create_table "databases", force: :cascade do |t|
      t.string   "host",            limit: 255
      t.string   "name",            limit: 255
      t.string   "username",        limit: 255
      t.string   "password",        limit: 255
      t.integer  "organisation_id", limit: 4
      t.string   "location",        limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "databases", ["organisation_id"], name: "index_databases_on_organisation_id", using: :btree

    create_table "domains", force: :cascade do |t|
      t.integer  "organisation_id", limit: 4,   default: 0,    null: false
      t.string   "name",            limit: 255, default: "",   null: false
      t.integer  "forwarding_id",   limit: 4
      t.date     "registered_on",                              null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "with_us",                     default: true, null: false
    end

    add_index "domains", ["organisation_id"], name: "index_domains_on_organisation_id", using: :btree

    create_table "email_addresses", force: :cascade do |t|
      t.integer  "organisation_id", limit: 4
      t.integer  "user_id",         limit: 4
      t.string   "address",         limit: 255, default: "", null: false
      t.string   "password",        limit: 255, default: "", null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "email_addresses", ["organisation_id"], name: "index_email_addresses_on_organisation_id", using: :btree
    add_index "email_addresses", ["user_id"], name: "index_email_addresses_on_user_id", using: :btree

    create_table "hosting_accounts", force: :cascade do |t|
      t.integer  "domain_id",                 limit: 4,                           default: 0,      null: false
      t.string   "ftp_host",                  limit: 255,                         default: "",     null: false
      t.string   "username",                  limit: 255,                         default: "",     null: false
      t.string   "password",                  limit: 255,                         default: "",     null: false
      t.date     "started_on",                                                                     null: false
      t.string   "host_name",                 limit: 255,                         default: "",     null: false
      t.date     "backed_up_on",                                                                   null: false
      t.integer  "backup_cycle",              limit: 4,                           default: 14,     null: false
      t.decimal  "annual_fee",                            precision: 6, scale: 2, default: 0.0,    null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "expected_http_status_code", limit: 255,                         default: "200",  null: false
      t.string   "scheme",                    limit: 255,                         default: "http", null: false
      t.integer  "port",                      limit: 4,                           default: 80,     null: false
      t.boolean  "maintained",                                                    default: true,   null: false
    end

    add_index "hosting_accounts", ["domain_id"], name: "index_hosting_accounts_on_domain_id", using: :btree

    create_table "note_pads", force: :cascade do |t|
      t.integer  "organisation_id", limit: 4,     default: 0,  null: false
      t.string   "title",           limit: 255,   default: "", null: false
      t.text     "content",         limit: 65535,              null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "note_pads", ["organisation_id"], name: "index_note_pads_on_organisation_id", using: :btree

    create_table "numbers", force: :cascade do |t|
      t.integer  "organisation_id", limit: 4
      t.integer  "user_id",         limit: 4
      t.string   "teltype",         limit: 255, default: "tel", null: false
      t.string   "note",            limit: 255, default: "",    null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "number",          limit: 255, default: "",    null: false
    end

    add_index "numbers", ["organisation_id"], name: "index_numbers_on_organisation_id", using: :btree
    add_index "numbers", ["user_id"], name: "index_numbers_on_user_id", using: :btree

    create_table "organisations", force: :cascade do |t|
      t.string   "name",           limit: 255, default: "",    null: false
      t.datetime "last_contacted",                             null: false
      t.integer  "contact_cycle",  limit: 4,   default: 90,    null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "last_viewed_at"
      t.boolean  "on_stop",                    default: false, null: false
      t.boolean  "archived",                   default: false, null: false
    end

    add_index "organisations", ["last_viewed_at"], name: "index_organisations_on_last_viewed_at", using: :btree
    add_index "organisations", ["updated_at"], name: "index_organisations_on_updated_at", using: :btree

    create_table "taggings", force: :cascade do |t|
      t.integer  "tag_id",        limit: 4
      t.integer  "taggable_id",   limit: 4
      t.string   "taggable_type", limit: 255
      t.integer  "tagger_id",     limit: 4
      t.string   "tagger_type",   limit: 255
      t.string   "context",       limit: 128
      t.datetime "created_at"
    end

    add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

    create_table "tags", force: :cascade do |t|
      t.string  "name",           limit: 255
      t.integer "taggings_count", limit: 4,   default: 0
    end

    add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

    create_table "timesheet_entries", force: :cascade do |t|
      t.integer  "organisation_id", limit: 4,                              default: 0,     null: false
      t.integer  "user_id",         limit: 4,                              default: 0,     null: false
      t.text     "description",     limit: 65535,                                          null: false
      t.decimal  "invoice_value",                 precision: 10, scale: 2, default: 0.0,   null: false
      t.boolean  "chargeable",                                             default: false, null: false
      t.integer  "minutes",         limit: 4,                              default: 0,     null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "started_at",                                                             null: false
    end

    add_index "timesheet_entries", ["organisation_id"], name: "index_timesheet_entries_on_organisation_id", using: :btree
    add_index "timesheet_entries", ["started_at"], name: "index_timesheet_entries_on_started_at", using: :btree
    add_index "timesheet_entries", ["user_id"], name: "index_timesheet_entries_on_user_id", using: :btree

    create_table "users", force: :cascade do |t|
      t.string   "email",                 limit: 255, default: "",    null: false
      t.string   "name",                  limit: 255, default: "",    null: false
      t.string   "encrypted_password",    limit: 255
      t.string   "salt",                  limit: 255
      t.boolean  "admin",                             default: false, null: false
      t.string   "forgot_password_token", limit: 255, default: "",    null: false
      t.integer  "organisation_id",       limit: 4,   default: 0,     null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "staff",                             default: false, null: false
    end

    add_index "users", ["staff"], name: "index_users_on_staff", using: :btree
    add_index "users", ["updated_at"], name: "index_users_on_updated_at", using: :btree
  end
end
