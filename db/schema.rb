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

ActiveRecord::Schema.define(version: 20160420141852) do

  create_table "bus_stops", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "street",     limit: 255
    t.string   "district",   limit: 255
    t.string   "state",      limit: 255
    t.decimal  "latitude",               precision: 13, scale: 10
    t.decimal  "longitude",              precision: 13, scale: 10
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "buses", force: :cascade do |t|
    t.string   "bus_num",          limit: 255
    t.string   "registration_num", limit: 255
    t.string   "status",           limit: 255
    t.decimal  "latitude",                     precision: 13, scale: 10
    t.decimal  "longitude",                    precision: 13, scale: 10
    t.integer  "capacity",         limit: 4
    t.integer  "seat_avail",       limit: 4
    t.string   "ac_nonac",         limit: 255
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.integer  "bus_stop_id",      limit: 4
  end

  add_index "buses", ["bus_stop_id"], name: "index_buses_on_bus_stop_id", using: :btree
  add_index "buses", ["user_id"], name: "index_buses_on_user_id", using: :btree

  create_table "privileges", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "privileges", ["role_id"], name: "index_privileges_on_role_id", using: :btree
  add_index "privileges", ["user_id"], name: "index_privileges_on_user_id", using: :btree

  create_table "reaches", force: :cascade do |t|
    t.integer  "bus_id",      limit: 4
    t.integer  "bus_stop_id", limit: 4
    t.integer  "stop_num",    limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "reaches", ["bus_id"], name: "index_reaches_on_bus_id", using: :btree
  add_index "reaches", ["bus_stop_id"], name: "index_reaches_on_bus_stop_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "role_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "employee_id",            limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "phone_no",               limit: 255
    t.date     "date_of_birth"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "authentication_token",   limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "buses", "bus_stops"
  add_foreign_key "buses", "users"
  add_foreign_key "privileges", "roles"
  add_foreign_key "privileges", "users"
  add_foreign_key "reaches", "bus_stops"
  add_foreign_key "reaches", "buses"
end
