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

ActiveRecord::Schema.define(version: 20140819134558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bases", force: true do |t|
    t.integer "user_id"
    t.string  "name"
  end

  create_table "building_types", force: true do |t|
    t.integer "type_id"
    t.string  "name"
    t.integer "construction_time"
    t.string  "product_model"
    t.integer "productsxMinute"
    t.integer "armor"
    t.boolean "unique"
  end

  create_table "building_units", force: true do |t|
    t.integer  "type_id"
    t.integer  "level"
    t.time     "finish_building"
    t.integer  "base_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "entity_stacks", force: true do |t|
    t.integer "base_id"
    t.integer "type_id"
    t.integer "amount"
  end

  create_table "entity_types", force: true do |t|
    t.integer "type_id"
    t.string  "name"
    t.integer "damage"
    t.integer "armor"
    t.integer "range"
  end

  create_table "resource_stacks", force: true do |t|
    t.integer "base_id"
    t.integer "type_id"
    t.integer "amount"
  end

  create_table "resource_types", force: true do |t|
    t.integer "type_id"
    t.string  "name"
  end

  create_table "user_ranks", force: true do |t|
    t.integer "total_resources"
    t.integer "total_money"
    t.integer "total_materials"
    t.integer "user_id"
    t.integer "total_level"
  end

  add_index "user_ranks", ["total_materials"], name: "index_user_ranks_on_total_materials", using: :btree
  add_index "user_ranks", ["total_money"], name: "index_user_ranks_on_total_money", using: :btree
  add_index "user_ranks", ["total_resources"], name: "index_user_ranks_on_total_resources", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
