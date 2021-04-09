# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_08_093818) do

  create_table "buildings", force: :cascade do |t|
    t.string "name"
    t.integer "planet_id"
    t.integer "food_price", default: 0
    t.integer "metal_price", default: 0
    t.integer "thorium_price", default: 0
    t.integer "lvl", default: 0
    t.integer "conso_power", default: 0
    t.integer "time_to_build", default: 0
    t.integer "production", default: 0
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planets", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", default: "Terre"
    t.integer "conso_tot", default: 0
    t.float "food_tot"
    t.integer "total_food_stock", default: 1000
    t.datetime "food_time", default: Time.now
    t.integer "total_metal_stock", default: 1000
    t.datetime "metal_time", default: Time.now
    t.integer "total_thorium_stock", default: 1000
    t.datetime "thorium_time", default: Time.now
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_planets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at"
    t.datetime "reset_sent_at"
    t.string "reset_digest"
    t.boolean "actif"
    t.datetime "last_connection"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
