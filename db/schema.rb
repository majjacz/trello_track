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

ActiveRecord::Schema.define(version: 20130702211206) do

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.integer  "project_id", null: false
    t.integer  "user_id",    null: false
    t.string   "name"
    t.string   "card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "time_records", force: true do |t|
    t.integer  "task_id",    null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "time_records", ["task_id"], name: "index_time_records_on_task_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.text     "email"
    t.string   "provider"
    t.string   "uid"
    t.text     "oauth_hash"
    t.string   "auth_token"
    t.string   "api_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "permissions", default: 0
    t.string   "avatar_hash"
  end

end
