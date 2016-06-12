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

ActiveRecord::Schema.define(version: 20160612031306) do

  create_table "bikes", force: :cascade do |t|
    t.integer  "maker_id",   limit: 4
    t.integer  "engine_id",  limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "bikes", ["engine_id"], name: "index_bikes_on_engine_id", using: :btree
  add_index "bikes", ["maker_id"], name: "index_bikes_on_maker_id", using: :btree

  create_table "engines", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "key",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "makers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "key",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "meters", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "key",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "bike_id",    limit: 4
    t.string   "year",       limit: 255
    t.integer  "meter_id",   limit: 4
    t.integer  "high",       limit: 4
    t.integer  "average",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "prices", ["bike_id"], name: "index_prices_on_bike_id", using: :btree
  add_index "prices", ["meter_id"], name: "index_prices_on_meter_id", using: :btree

  add_foreign_key "bikes", "engines"
  add_foreign_key "bikes", "makers"
  add_foreign_key "prices", "bikes"
  add_foreign_key "prices", "meters"
end
