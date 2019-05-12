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

ActiveRecord::Schema.define(version: 20190504123709) do

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "make_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "make_summaries", force: :cascade do |t|
    t.integer "make_id"
    t.integer "answer_1_ct"
    t.integer "answer_2_ct"
    t.integer "answer_3_ct"
    t.integer "answer_4_ct"
    t.integer "answer_5_ct"
    t.integer "answer_6_ct"
    t.integer "answer_7_ct"
    t.integer "answer_8_ct"
    t.integer "answer_9_ct"
    t.integer "answer_10_ct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answer_all_ct"
  end

  create_table "makes", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "answer_1"
    t.string "answer_2"
    t.string "answer_3"
    t.string "answer_4"
    t.string "answer_5"
    t.string "answer_6"
    t.string "answer_7"
    t.string "answer_8"
    t.string "answer_9"
    t.string "answer_10"
    t.string "question"
    t.integer "category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_name"
    t.integer "sex"
    t.integer "age"
    t.string "profession"
    t.string "address_pref"
    t.integer "annual_income"
    t.string "password_digest"
  end

  create_table "votings", force: :cascade do |t|
    t.integer "make_id"
    t.integer "user_id"
    t.integer "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
