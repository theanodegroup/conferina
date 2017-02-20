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

ActiveRecord::Schema.define(version: 20170220031714) do

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
    t.integer  "category_id"
    t.string   "avatar"
    t.string   "timezone"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "coming_soon"
    t.string   "address"
    t.date     "call_for"
    t.text     "extra_desc"
    t.date     "submission"
    t.date     "notification"
    t.boolean  "is_published",                           default: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.decimal  "lat",          precision: 17, scale: 14
    t.decimal  "lng",          precision: 17, scale: 14
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "favoritable_id"
    t.string   "favoritable_type"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "favorites", ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable_type_and_favoritable_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "location_types", force: :cascade do |t|
    t.string   "category"
    t.boolean  "by_admin",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "avatar"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.string   "map_address"
    t.string   "avatar"
    t.string   "detailed_avatar"
    t.string   "phone"
    t.text     "description"
    t.string   "subtitle"
    t.decimal  "lat",              precision: 17, scale: 14
    t.decimal  "lng",              precision: 17, scale: 14
    t.integer  "event_id"
    t.integer  "location_type_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "venue_id"
  end

  add_index "locations", ["event_id"], name: "index_locations_on_event_id", using: :btree
  add_index "locations", ["location_type_id"], name: "index_locations_on_location_type_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "content"
    t.integer  "notable_id"
    t.string   "notable_type"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "notes", ["notable_type", "notable_id"], name: "index_notes_on_notable_type_and_notable_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "subtitle"
    t.text     "description"
    t.string   "avatar"
    t.string   "detailed_avatar"
    t.string   "website"
    t.string   "youtube"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "phone"
    t.string   "email"
    t.integer  "event_id"
    t.integer  "person_type_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "people", ["event_id"], name: "index_people_on_event_id", using: :btree
  add_index "people", ["person_type_id"], name: "index_people_on_person_type_id", using: :btree
  add_index "people", ["user_id"], name: "index_people_on_user_id", using: :btree

  create_table "person_types", force: :cascade do |t|
    t.string   "category"
    t.boolean  "by_admin",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "avatar"
    t.text     "description"
  end

  create_table "persons_sessions", id: false, force: :cascade do |t|
    t.integer "person_id"
    t.integer "session_id"
  end

  add_index "persons_sessions", ["person_id", "session_id"], name: "index_persons_sessions_on_person_id_and_session_id", using: :btree

  create_table "session_types", force: :cascade do |t|
    t.string   "category"
    t.boolean  "by_admin",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "avatar"
    t.text     "description"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "avatar"
    t.string   "detailed_avatar"
    t.string   "other_time"
    t.integer  "event_id"
    t.integer  "session_type_id"
    t.integer  "location_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_published",    default: false
  end

  add_index "sessions", ["event_id"], name: "index_sessions_on_event_id", using: :btree
  add_index "sessions", ["location_id"], name: "index_sessions_on_location_id", using: :btree
  add_index "sessions", ["session_type_id"], name: "index_sessions_on_session_type_id", using: :btree

  create_table "socials", force: :cascade do |t|
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "youtube"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "socials", ["event_id"], name: "index_socials_on_event_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_events", id: false, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "event_id"
  end

  add_index "tags_events", ["tag_id", "event_id"], name: "index_tags_events_on_tag_id_and_event_id", using: :btree

  create_table "tags_sessions", id: false, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "session_id"
  end

  add_index "tags_sessions", ["tag_id", "session_id"], name: "index_tags_sessions_on_tag_id_and_session_id", using: :btree

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
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_category_types", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_type_id"
  end

  add_index "users_category_types", ["user_id", "category_type_id"], name: "index_users_category_types_on_user_id_and_category_type_id", using: :btree

  create_table "users_events", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  add_index "users_events", ["user_id", "event_id"], name: "index_users_events_on_user_id_and_event_id", using: :btree

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

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.string   "map_address"
    t.string   "avatar"
    t.string   "detailed_avatar"
    t.string   "phone"
    t.text     "description"
    t.string   "subtitle"
    t.decimal  "lat",              precision: 17, scale: 14
    t.decimal  "lng",              precision: 17, scale: 14
    t.integer  "user_id"
    t.integer  "location_type_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "venues", ["location_type_id"], name: "index_venues_on_location_type_id", using: :btree
  add_index "venues", ["user_id"], name: "index_venues_on_user_id", using: :btree

  add_foreign_key "favorites", "users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "notes", "users"
end
