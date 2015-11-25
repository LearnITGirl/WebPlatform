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

ActiveRecord::Schema.define(version: 20151114065745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string   "known_programming_languages",           default: [], array: true
    t.string   "programming_language"
    t.text     "project_proposal"
    t.text     "programming_experience"
    t.text     "roadmap"
    t.integer  "time_availability",           limit: 2
    t.string   "engagements",                           default: [], array: true
    t.string   "sources",                               default: [], array: true
    t.string   "build_step"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "mentee_level",                     default: [],    array: true
    t.boolean  "experienced",                      default: false
    t.text     "mentor_experience"
    t.text     "background"
    t.boolean  "git",                              default: false
    t.string   "programming_languages",            default: [],    array: true
    t.text     "programming_experience"
    t.text     "application_idea"
    t.text     "concept_explanation"
    t.integer  "time_availability",      limit: 2
    t.string   "engagements",                      default: [],    array: true
    t.string   "sources",                          default: [],    array: true
    t.string   "build_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                     null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
