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

ActiveRecord::Schema.define(version: 20170402153221) do

  create_table "buildings", force: :cascade do |t|
    t.string   "name"
    t.integer  "planet_id",                 null: false
    t.integer  "food_price",    default: 0
    t.integer  "metal_price",   default: 0
    t.integer  "thorium_price", default: 0
    t.integer  "lvl",           default: 1
    t.integer  "conso_power",   default: 0
    t.integer  "time_to_build", default: 0
    t.integer  "production",    default: 0
    t.integer  "position",                  null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "planets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       default: "Terre"
    t.integer  "conso_tot",  default: 0
    t.float    "food_tot"
    t.integer  "place_1"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_planets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "actif"
    t.datetime "last_connection"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
