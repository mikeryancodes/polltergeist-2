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

ActiveRecord::Schema.define(version: 20151216234923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_choices", force: :cascade do |t|
    t.integer  "poll_id",    null: false
    t.string   "letter",     null: false
    t.string   "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "answer_choices", ["poll_id"], name: "index_answer_choices_on_poll_id", using: :btree

  create_table "poll_groups", force: :cascade do |t|
    t.integer  "author_id",   null: false
    t.string   "title",       null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "poll_groups", ["author_id"], name: "index_poll_groups_on_author_id", using: :btree

  create_table "polls", force: :cascade do |t|
    t.text     "question",                        null: false
    t.string   "poll_identifier"
    t.integer  "poll_group_id"
    t.boolean  "locked",          default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "author_id",                       null: false
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "answer_choice_id", null: false
    t.integer  "respondent_id",    null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "responses", ["answer_choice_id"], name: "index_responses_on_answer_choice_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end