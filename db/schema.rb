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

ActiveRecord::Schema.define(version: 20150118015004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hunts", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "location_id", null: false
    t.integer  "user_id",     null: false
    t.string   "category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "huntsplayedusers", force: :cascade do |t|
    t.integer  "hunt_id",                          null: false
    t.integer  "user_id",                          null: false
    t.integer  "question_no",                      null: false
    t.string   "user_session_id",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address",         default: "None", null: false
  end

  add_index "huntsplayedusers", ["hunt_id", "question_no", "user_session_id"], name: "byhuntquestionuser", unique: true, using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "address",    null: false
    t.float    "latitude",   null: false
    t.float    "longitude",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude", unique: true, using: :btree

  create_table "questionsets", force: :cascade do |t|
    t.integer  "hunt_id",     null: false
    t.string   "question",    null: false
    t.integer  "question_no", null: false
    t.string   "address",     null: false
    t.float    "latitude",    null: false
    t.float    "longitude",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hunt_photo"
    t.string   "description"
  end

  add_index "questionsets", ["hunt_id", "question_no"], name: "index_questionsets_on_hunt_id_and_question_no", unique: true, using: :btree

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
    t.string   "name",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar_url"
    t.string   "profile_photo"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
