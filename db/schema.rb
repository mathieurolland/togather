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

ActiveRecord::Schema.define(version: 20160824175913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "selected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connections", force: :cascade do |t|
    t.string   "status"
    t.integer  "guest_id"
    t.integer  "host_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_connections_on_guest_id", using: :btree
    t.index ["host_id"], name: "index_connections_on_host_id", using: :btree
  end

  create_table "meetings", force: :cascade do |t|
    t.text     "guest_review"
    t.text     "host_review"
    t.datetime "date"
    t.integer  "connection_id"
    t.integer  "place_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["connection_id"], name: "index_meetings_on_connection_id", using: :btree
    t.index ["place_id"], name: "index_meetings_on_place_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "meeting_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_messages_on_meeting_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.string   "phone_number"
    t.string   "type_partner"
    t.integer  "pax"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_places_on_user_id", using: :btree
  end

  create_table "recommended_users", force: :cascade do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recommended_users_on_user_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_skills_on_category_id", using: :btree
  end

  create_table "user_skills", force: :cascade do |t|
    t.integer  "skill_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_user_skills_on_skill_id", using: :btree
    t.index ["user_id"], name: "index_user_skills_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "status"
    t.string   "gender"
    t.string   "work_place"
    t.date     "birthday"
    t.text     "bio"
    t.string   "uid"
    t.string   "provider"
    t.string   "picture_url"
    t.string   "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "meetings", "connections"
  add_foreign_key "meetings", "places"
  add_foreign_key "messages", "meetings"
  add_foreign_key "messages", "users"
  add_foreign_key "places", "users"
  add_foreign_key "recommended_users", "users"
  add_foreign_key "skills", "categories"
  add_foreign_key "user_skills", "skills"
  add_foreign_key "user_skills", "users"
end
