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

ActiveRecord::Schema.define(version: 20171020020329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application_matches", force: :cascade do |t|
    t.integer  "mentor_application_id"
    t.integer  "mentee_application_id"
    t.boolean  "confirmed",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assigned_badges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.boolean  "displayed",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assigned_badges", ["badge_id", "user_id"], name: "index_assigned_badges_on_badge_id_and_user_id", using: :btree
  add_index "assigned_badges", ["user_id", "badge_id"], name: "index_assigned_badges_on_user_id_and_badge_id", using: :btree

  create_table "badges", force: :cascade do |t|
    t.integer "name"
    t.string  "image"
    t.text    "description"
    t.string  "thumbnail"
  end

  create_table "badges_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "badge_id", null: false
  end

  add_index "badges_users", ["badge_id", "user_id"], name: "index_badges_users_on_badge_id_and_user_id", using: :btree
  add_index "badges_users", ["user_id", "badge_id"], name: "index_badges_users_on_user_id_and_badge_id", using: :btree

  create_table "editions", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "name"
    t.datetime "registration_started_at"
    t.datetime "registration_closed_at"
  end

  create_table "email_templates", force: :cascade do |t|
    t.string   "subject",                null: false
    t.text     "body",                   null: false
    t.integer  "recipients", default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.decimal "score"
    t.integer "mentor_application_id"
    t.integer "mentee_application_id"
    t.integer "user_id"
  end

  create_table "final_surveys", force: :cascade do |t|
    t.integer  "edition_id"
    t.integer  "mentor_id"
    t.integer  "mentee_id"
    t.integer  "project_id"
    t.text     "mentee_impression"
    t.text     "mentor_impression"
    t.text     "mentee_expectations"
    t.text     "mentor_expectations"
    t.text     "mentee_project_summary"
    t.text     "mentor_project_summary"
    t.text     "mentee_feedback"
    t.text     "mentor_feedback"
    t.text     "mentee_future_plans"
    t.string   "mentee_program_duration"
    t.string   "mentor_program_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentee_applications", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "gender"
    t.string   "country"
    t.string   "program_country"
    t.string   "time_zone"
    t.text     "motivation"
    t.string   "english_level"
    t.text     "experience"
    t.string   "programming_level"
    t.text     "background"
    t.string   "known_programming_languages",                default: [], array: true
    t.string   "old_programming_language"
    t.text     "project_proposal"
    t.text     "programming_experience"
    t.text     "roadmap"
    t.integer  "time_availability",                limit: 2
    t.string   "engagements",                                default: [], array: true
    t.string   "sources",                                    default: [], array: true
    t.string   "build_step"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "other_programming_language"
    t.string   "other_known_programming_language"
    t.integer  "state",                            limit: 2, default: 1
    t.text     "rejection_reason"
    t.integer  "evaluator_id"
    t.datetime "results_send_at"
    t.boolean  "communicating_in_english"
    t.boolean  "send_to_mentor_confirmed"
    t.string   "operating_system"
    t.string   "team_work_experience"
    t.boolean  "previous_programming_experience"
    t.integer  "programming_language_id"
    t.integer  "edition_id"
    t.datetime "confirmation_email_sent_at"
    t.text     "resignation_reason"
    t.text     "rematch_reason"
  end

  create_table "mentee_midterm_evaluations", force: :cascade do |t|
    t.integer  "mentee_id"
    t.text     "project_progress"
    t.text     "language_progress"
    t.text     "positive_aspects"
    t.text     "future_plans"
    t.integer  "weekly_hours"
    t.text     "mentor_impression"
    t.text     "extra_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "edition_id"
  end

  create_table "mentor_applications", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "gender"
    t.string   "country"
    t.string   "program_country"
    t.string   "time_zone"
    t.text     "motivation"
    t.string   "english_level"
    t.string   "mentee_level",                         default: [],    array: true
    t.boolean  "experienced",                          default: false
    t.text     "mentor_experience"
    t.text     "background"
    t.boolean  "git",                                  default: false
    t.string   "old_programming_languages",            default: [],    array: true
    t.text     "programming_experience"
    t.text     "application_idea"
    t.text     "concept_explanation"
    t.integer  "time_availability",          limit: 2
    t.string   "engagements",                          default: [],    array: true
    t.string   "sources",                              default: [],    array: true
    t.string   "build_step"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "other_programming_language"
    t.integer  "state",                      limit: 2, default: 1
    t.text     "rejection_reason"
    t.integer  "evaluator_id"
    t.datetime "results_send_at"
    t.boolean  "communicating_in_english"
    t.jsonb    "programming_languages_info"
    t.string   "operating_system"
    t.integer  "edition_id"
    t.datetime "confirmation_email_sent_at"
    t.text     "resignation_reason"
    t.text     "rematch_reason"
  end

  create_table "mentor_applications_programming_languages", id: false, force: :cascade do |t|
    t.integer "mentor_application_id",   null: false
    t.integer "programming_language_id", null: false
  end

  create_table "mentor_midterm_evaluations", force: :cascade do |t|
    t.integer  "mentor_id"
    t.integer  "edition_id"
    t.text     "project_progress"
    t.text     "positive_aspects"
    t.integer  "weekly_hours"
    t.text     "future_plans"
    t.text     "mentee_impression"
    t.text     "extra_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", force: :cascade do |t|
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programming_languages", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "language"
    t.text     "description"
    t.string   "github_link"
    t.integer  "mentor_id"
    t.integer  "mentee_id"
    t.integer  "edition_id"
    t.integer  "mentor_evaluation"
    t.integer  "mentee_feedback"
    t.integer  "mentee_project_status"
    t.integer  "github_repo_status"
    t.integer  "midterm_evaluation_status", default: 0
    t.datetime "last_commit"
    t.integer  "programming_language_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.integer  "status",       limit: 2
    t.integer  "project_id"
    t.integer  "week"
    t.integer  "finished_by"
    t.datetime "deleted_at"
    t.datetime "updated_at"
    t.datetime "completed_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                     null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                            limit: 2
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "organiser_token"
    t.string   "avatar"
    t.boolean  "is_missing",                                default: false
    t.string   "program_country"
    t.string   "timezone"
    t.integer  "edition_id"
    t.string   "registration_token"
    t.datetime "missing_since"
    t.datetime "results_send_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address"
    t.date     "send_warning_email_after"
    t.integer  "mentee_application_id"
    t.integer  "mentor_application_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at", using: :btree
  add_index "users", ["mentee_application_id"], name: "index_users_on_mentee_application_id", using: :btree
  add_index "users", ["mentor_application_id"], name: "index_users_on_mentor_application_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  create_table "weeks", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer  "number"
    t.integer  "edition_id"
  end

end
