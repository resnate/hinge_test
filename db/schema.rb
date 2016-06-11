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

ActiveRecord::Schema.define(version: 20160608121335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "survey_definitions", force: :cascade do |t|
    t.string   "name"
    t.integer  "week_indices",     default: [], array: true
    t.integer  "lateness_allowed"
    t.json     "format"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_obligations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "survey_definition_id"
    t.datetime "due_at"
    t.datetime "expires_at"
    t.datetime "submitted_at"
    t.json     "submission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "program_starts_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer "team_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "token"
  end

end
