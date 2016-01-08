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

ActiveRecord::Schema.define(version: 20160108125323) do

  create_table "articles", force: :cascade do |t|
    t.string   "article_name"
    t.integer  "article_content"
    t.string   "article_type"
    t.string   "article_category"
    t.integer  "quantity_bigbox"
    t.integer  "quantity_smallbox"
    t.integer  "quantity_pile"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.decimal  "washing_price"
    t.decimal  "handwash_price"
    t.decimal  "tab_price"
    t.decimal  "deposit_price"
    t.decimal  "sell_price"
    t.boolean  "is_washable"
    t.boolean  "rekwup_cup"
  end

  create_table "boxdetails", force: :cascade do |t|
    t.integer  "box_id"
    t.integer  "article_id"
    t.integer  "box_article_quantity"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "boxes", force: :cascade do |t|
    t.string   "box_name"
    t.boolean  "box_regular"
    t.string   "box_type"
    t.integer  "box_detail_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "bigbox"
    t.boolean  "smallbox"
    t.boolean  "box_is_full"
    t.boolean  "mixed"
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_name"
    t.date     "event_start_date"
    t.date     "event_end_date"
    t.integer  "expected_pax"
    t.integer  "last_pax"
    t.string   "post_code"
    t.string   "city"
    t.string   "country"
    t.text     "comment"
    t.boolean  "cuptwenty"
    t.boolean  "cuptwentyfive"
    t.boolean  "cupforty"
    t.boolean  "cupfifty"
    t.boolean  "cuplitre"
    t.boolean  "cupwine"
    t.boolean  "cupcava"
    t.boolean  "cupshot"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "creator_id"
    t.integer  "organizer_id"
    t.boolean  "creatorganizer"
    t.boolean  "party"
    t.boolean  "dinner"
    t.integer  "last_consumption"
  end

  create_table "negociated_prices", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "client_id"
    t.decimal  "washing_price"
    t.decimal  "handwash_price"
    t.decimal  "tab_price"
    t.decimal  "deposit_price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.boolean  "individual"
    t.boolean  "company"
    t.boolean  "non_profit"
    t.boolean  "institution"
    t.boolean  "admin"
    t.boolean  "staff"
    t.boolean  "client"
    t.string   "company_name"
    t.string   "first_name"
    t.boolean  "negociated_price"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
