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

ActiveRecord::Schema.define(version: 0) do

  create_table "forums", primary_key: "forum_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "forum_nm", limit: 1000, null: false
    t.integer "parent_forum_id"
    t.datetime "create_dttm", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "thread_replies", primary_key: ["trd_id", "rep_trd_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "trd_id", null: false
    t.integer "rep_trd_id", null: false
    t.integer "lvl", default: 1, null: false
  end

  create_table "threads", primary_key: "trd_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "forum_id", null: false
    t.string "title", limit: 1000, null: false
    t.string "content", limit: 4000, null: false
    t.string "post_user_id", limit: 15, null: false
    t.datetime "write_dttm", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "modify_dttm", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "close_dttm"
  end

end
