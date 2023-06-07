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

ActiveRecord::Schema[7.0].define(version: 2023_06_07_142050) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "description"
    t.integer "color_protocol"
    t.bigint "hospital_id", null: false
    t.boolean "done", default: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_appointments_on_hospital_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "coverages", force: :cascade do |t|
    t.bigint "insurance_plan_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_coverages_on_hospital_id"
    t.index ["insurance_plan_id"], name: "index_coverages_on_insurance_plan_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insurance_plans", force: :cascade do |t|
    t.string "name"
    t.integer "product"
    t.integer "id_code"
    t.string "plan"
    t.integer "cns"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_insurance_plans_on_user_id"
  end

  create_table "medical_datum", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "blood_type"
    t.string "allergies"
    t.float "weight"
    t.float "height"
    t.string "health_conditions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_medical_datum_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.bigint "cpf"
    t.date "birthdate"
    t.string "address"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "hospitals"
  add_foreign_key "appointments", "users"
  add_foreign_key "coverages", "hospitals"
  add_foreign_key "coverages", "insurance_plans"
  add_foreign_key "insurance_plans", "users"
  add_foreign_key "medical_datum", "users"
end
