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

ActiveRecord::Schema.define(version: 2019_08_03_155219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "club_type"
    t.string "name"
    t.text "description"
    t.string "url"
    t.string "contact_email"
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "series_id"
    t.index ["club_type"], name: "index_clubs_on_club_type"
    t.index ["name"], name: "index_clubs_on_name"
    t.index ["region_id"], name: "index_clubs_on_region_id"
    t.index ["series_id"], name: "index_clubs_on_series_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "instructions"
    t.float "fee"
    t.datetime "start_on"
    t.datetime "end_on"
    t.bigint "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "series_id"
    t.datetime "registration_start"
    t.datetime "registration_end"
    t.integer "max_registrations"
    t.index ["club_id"], name: "index_events_on_club_id"
    t.index ["end_on"], name: "index_events_on_end_on"
    t.index ["series_id"], name: "index_events_on_series_id"
    t.index ["start_on"], name: "index_events_on_start_on"
  end

  create_table "race_results", force: :cascade do |t|
    t.bigint "race_id"
    t.string "course"
    t.datetime "start_on"
    t.datetime "end_on"
    t.boolean "dns", default: false
    t.boolean "dnf", default: false
    t.boolean "disqualified", default: false
    t.float "penalty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vessel_id"
    t.index ["race_id"], name: "index_race_results_on_race_id"
    t.index ["vessel_id"], name: "index_race_results_on_vessel_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.string "boat_type"
    t.integer "rating"
    t.float "sail_plan_i"
    t.float "sail_plan_j"
    t.float "sail_plan_p"
    t.float "sail_plan_e"
    t.float "sail_plan_py"
    t.float "sail_plan_ey"
    t.float "displacement"
    t.float "length_water_line"
    t.float "draft"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_regions_on_parent_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.boolean "paid", default: false
    t.datetime "paid_on"
    t.string "invoice_id"
    t.text "notes"
    t.bigint "user_id"
    t.bigint "series_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_registrations_on_event_id"
    t.index ["series_id"], name: "index_registrations_on_series_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "series", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "instructions"
    t.float "fee"
    t.bigint "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "registration_start"
    t.datetime "registration_end"
    t.integer "max_registrations"
    t.index ["club_id"], name: "index_series_on_club_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "accept_terms"
    t.bigint "club_id"
    t.bigint "vessel_id"
    t.string "api_token"
    t.index ["club_id"], name: "index_users_on_club_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["vessel_id"], name: "index_users_on_vessel_id"
  end

  create_table "vessels", force: :cascade do |t|
    t.string "name"
    t.string "make"
    t.string "model"
    t.float "length"
    t.float "beam"
    t.float "draft"
    t.string "sail_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.bigint "rating_id"
    t.index ["owner_id"], name: "index_vessels_on_owner_id"
    t.index ["rating_id"], name: "index_vessels_on_rating_id"
  end

  add_foreign_key "clubs", "regions"
  add_foreign_key "events", "clubs"
  add_foreign_key "events", "series"
  add_foreign_key "race_results", "events", column: "race_id"
  add_foreign_key "registrations", "users"
  add_foreign_key "series", "clubs"
end
