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

ActiveRecord::Schema.define(version: 20160728072751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "category_types", force: :cascade do |t|
    t.string   "category"
    t.boolean  "by_admin",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "avatar"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "avatar"
    t.string   "timezone"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "coming_soon"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "extra_name"
    t.text     "extra_desc"
    t.string   "extra_date_first_name"
    t.string   "extra_date_second_name"
    t.date     "extra_date_first"
    t.date     "extra_date_second"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.decimal  "lat",                    precision: 10, scale: 7
    t.decimal  "lng",                    precision: 10, scale: 7
  end

  create_table "location_types", force: :cascade do |t|
    t.string   "category"
    t.boolean  "by_admin",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "avatar"
  end

  create_table "person_types", force: :cascade do |t|
    t.string   "category"
    t.boolean  "by_admin",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "avatar"
  end

  create_table "session_types", force: :cascade do |t|
    t.string   "category"
    t.boolean  "by_admin",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "avatar"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_category_types", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_type_id"
  end

  add_index "users_category_types", ["user_id", "category_type_id"], name: "index_users_category_types_on_user_id_and_category_type_id", using: :btree

  create_table "users_location_types", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "location_type_id"
  end

  add_index "users_location_types", ["user_id", "location_type_id"], name: "index_users_location_types_on_user_id_and_location_type_id", using: :btree

  create_table "users_person_types", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "person_type_id"
  end

  add_index "users_person_types", ["user_id", "person_type_id"], name: "index_users_person_types_on_user_id_and_person_type_id", using: :btree

  create_table "users_session_types", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "session_type_id"
  end

  add_index "users_session_types", ["user_id", "session_type_id"], name: "index_users_session_types_on_user_id_and_session_type_id", using: :btree

end
