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

ActiveRecord::Schema.define(version: 20150212173442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.integer  "coach_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.time     "beginning_of_business_day"
    t.time     "end_of_business_day"
    t.integer  "duration"
    t.boolean  "auto_confirmation",         default: false
    t.text     "recurring_calendar_days",   default: [],    array: true
    t.integer  "cancellation_period"
    t.decimal  "late_cancellation_fee"
    t.integer  "maximum_of_participants"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "availabilities", ["coach_id"], name: "index_availabilities_on_coach_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "canceled_at"
    t.integer  "canceled_by"
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookings", ["coach_id"], name: "index_bookings_on_coach_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "exercise_descriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                  limit: 50,  null: false
    t.string   "uniquable_name",        limit: 50,  null: false
    t.string   "short_name_for_mobile", limit: 25,  null: false
    t.text     "description",                       null: false
    t.boolean  "distance"
    t.boolean  "duration"
    t.boolean  "load"
    t.boolean  "repetition"
    t.string   "tempo",                 limit: 8
    t.boolean  "unilateral_execution"
    t.boolean  "unilateral_loading"
    t.string   "video_url",             limit: 100
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercise_descriptions", ["user_id", "uniquable_name"], name: "index_exercise_descriptions_on_user_id_and_uniquable_name", unique: true, using: :btree
  add_index "exercise_descriptions", ["user_id"], name: "index_exercise_descriptions_on_user_id", using: :btree

  create_table "exercise_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.integer  "exercise_description_id"
    t.integer  "exercise_set_log_id"
    t.decimal  "distance"
    t.integer  "duration"
    t.decimal  "load"
    t.integer  "repetition"
    t.string   "tempo",                   limit: 8
    t.boolean  "unilateral_loading"
    t.boolean  "unilateral_execution"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercise_logs", ["coach_id"], name: "index_exercise_logs_on_coach_id", using: :btree
  add_index "exercise_logs", ["exercise_description_id"], name: "index_exercise_logs_on_exercise_description_id", using: :btree
  add_index "exercise_logs", ["exercise_set_log_id"], name: "index_exercise_logs_on_exercise_set_log_id", using: :btree
  add_index "exercise_logs", ["user_id"], name: "index_exercise_logs_on_user_id", using: :btree

  create_table "exercise_plan_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.string   "name",       limit: 50, null: false
    t.text     "note",                  null: false
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercise_plan_logs", ["coach_id"], name: "index_exercise_plan_logs_on_coach_id", using: :btree
  add_index "exercise_plan_logs", ["user_id"], name: "index_exercise_plan_logs_on_user_id", using: :btree

  create_table "exercise_plans", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",           limit: 50, null: false
    t.string   "uniquable_name", limit: 50, null: false
    t.text     "description",               null: false
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercise_plans", ["user_id", "uniquable_name"], name: "index_exercise_plans_on_user_id_and_uniquable_name", unique: true, using: :btree
  add_index "exercise_plans", ["user_id"], name: "index_exercise_plans_on_user_id", using: :btree

  create_table "exercise_session_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.integer  "exercise_plan_log_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercise_session_logs", ["coach_id"], name: "index_exercise_session_logs_on_coach_id", using: :btree
  add_index "exercise_session_logs", ["exercise_plan_log_id"], name: "index_exercise_session_logs_on_exercise_plan_log_id", using: :btree
  add_index "exercise_session_logs", ["user_id"], name: "index_exercise_session_logs_on_user_id", using: :btree

  create_table "exercise_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "exercise_plan_id"
    t.string   "name",             limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercise_sessions", ["exercise_plan_id"], name: "index_exercise_sessions_on_exercise_plan_id", using: :btree
  add_index "exercise_sessions", ["user_id"], name: "index_exercise_sessions_on_user_id", using: :btree

  create_table "exercise_set_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.integer  "exercise_session_log_id"
    t.integer  "duration"
    t.integer  "repetition"
    t.integer  "rest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercise_set_logs", ["coach_id"], name: "index_exercise_set_logs_on_coach_id", using: :btree
  add_index "exercise_set_logs", ["exercise_session_log_id"], name: "index_exercise_set_logs_on_exercise_session_log_id", using: :btree
  add_index "exercise_set_logs", ["user_id"], name: "index_exercise_set_logs_on_user_id", using: :btree

  create_table "exercise_sets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "exercise_session_id"
    t.string   "name",                limit: 50
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercise_sets", ["exercise_session_id"], name: "index_exercise_sets_on_exercise_session_id", using: :btree
  add_index "exercise_sets", ["user_id"], name: "index_exercise_sets_on_user_id", using: :btree

  create_table "exercises", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "exercise_set_id"
    t.integer  "exercise_description_id"
    t.boolean  "distance_selected"
    t.decimal  "distance"
    t.boolean  "duration_selected"
    t.integer  "duration"
    t.boolean  "load_selected"
    t.decimal  "load"
    t.boolean  "repetition_selected"
    t.integer  "repetition"
    t.integer  "rest"
    t.string   "tempo",                   limit: 8
    t.boolean  "unilateral_loading"
    t.boolean  "unilateral_execution"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercises", ["exercise_description_id"], name: "index_exercises_on_exercise_description_id", using: :btree
  add_index "exercises", ["exercise_set_id"], name: "index_exercises_on_exercise_set_id", using: :btree
  add_index "exercises", ["user_id"], name: "index_exercises_on_user_id", using: :btree

  create_table "habit_descriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",           limit: 50,  null: false
    t.string   "uniquable_name", limit: 50,  null: false
    t.string   "summary",        limit: 100, null: false
    t.text     "description",                null: false
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "habit_descriptions", ["user_id", "uniquable_name"], name: "index_habit_descriptions_on_user_id_and_uniquable_name", unique: true, using: :btree
  add_index "habit_descriptions", ["user_id"], name: "index_habit_descriptions_on_user_id", using: :btree

  create_table "habit_logs", force: :cascade do |t|
    t.integer  "habit_description_id"
    t.integer  "user_id"
    t.text     "logged_at"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "habit_logs", ["habit_description_id"], name: "index_habit_logs_on_habit_description_id", using: :btree
  add_index "habit_logs", ["user_id"], name: "index_habit_logs_on_user_id", using: :btree

  create_table "habits", force: :cascade do |t|
    t.integer  "habit_description_id"
    t.integer  "product_id"
    t.string   "unit",                 limit: 50, null: false
    t.decimal  "size"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "habits", ["habit_description_id"], name: "index_habits_on_habit_description_id", using: :btree
  add_index "habits", ["product_id"], name: "index_habits_on_product_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   limit: 50,  null: false
    t.string   "uid",        limit: 50,  null: false
    t.string   "token",      limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["provider", "uid"], name: "index_identities_on_provider_and_uid", unique: true, using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "payment_plans", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                     null: false
    t.text     "description",              null: false
    t.decimal  "price",                    null: false
    t.string   "currency_iso_code",        null: false
    t.string   "billing_day_of_month",     null: false
    t.integer  "number_of_billing_cycles", null: false
    t.integer  "billing_frequency",        null: false
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_plans", ["user_id"], name: "index_payment_plans_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "payment_plan_id"
    t.string   "transaction_id",  limit: 50, null: false
    t.integer  "customer_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["payment_plan_id"], name: "index_payments_on_payment_plan_id", using: :btree
  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",        null: false
    t.text     "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name",     limit: 100, null: false
    t.string   "last_name",      limit: 100, null: false
    t.string   "company",        limit: 100
    t.string   "address1",       limit: 100
    t.string   "address2",       limit: 100
    t.string   "postal_code",    limit: 20
    t.string   "city",           limit: 100
    t.string   "state_province", limit: 100
    t.string   "country",        limit: 100
    t.string   "phone_number",   limit: 20
    t.string   "gender",         limit: 1
    t.date     "birth_date"
    t.integer  "height"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",           limit: 50, null: false
    t.string   "uniquable_name", limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["uniquable_name"], name: "index_roles_on_uniquable_name", unique: true, using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",           limit: 50, null: false
    t.string   "uniquable_name", limit: 50, null: false
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["uniquable_name"], name: "index_tags_on_uniquable_name", unique: true, using: :btree
  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "provider"
    t.string   "uid",                    default: "", null: false
    t.text     "tokens"
    t.string   "encrypted_password",     default: "", null: false
    t.datetime "reset_password_sent_at"
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "confirmation_token"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

end
