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

ActiveRecord::Schema.define(version: 20160212084241) do

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
    t.decimal  "weight"
    t.boolean  "is_cup"
    t.boolean  "is_lln"
    t.boolean  "is_patro"
    t.boolean  "is_bep"
    t.boolean  "is_cc"
    t.boolean  "is_ep"
    t.boolean  "is_eco"
    t.boolean  "is_wine"
    t.boolean  "is_cava"
    t.boolean  "is_big_box"
    t.boolean  "is_small_box"
    t.boolean  "is_top"
    t.boolean  "is_palette"
    t.boolean  "is_shot"
    t.boolean  "is_twenty"
    t.boolean  "is_twentyfive"
    t.boolean  "is_forty"
    t.boolean  "is_fifty"
    t.boolean  "is_litre"
    t.boolean  "transport"
    t.boolean  "age"
    t.boolean  "champagne"
    t.integer  "pile_smallbox"
  end

  create_table "attendances", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "bigbox"
    t.boolean  "smallbox"
    t.boolean  "box_is_full"
    t.boolean  "mixed"
    t.boolean  "lln_twentyfive"
    t.boolean  "lln_fifty"
    t.boolean  "lln_litre"
    t.boolean  "empty"
    t.boolean  "empty_box"
    t.boolean  "kpt_box"
    t.boolean  "is_cc"
    t.boolean  "is_ep"
    t.boolean  "is_eco"
    t.boolean  "is_wine"
    t.boolean  "is_cava"
    t.boolean  "is_twenty"
    t.boolean  "is_twentyfive"
    t.boolean  "is_fifty"
    t.boolean  "is_forty"
    t.boolean  "is_litre"
    t.boolean  "is_shot"
    t.boolean  "is_bep"
    t.boolean  "is_rekwup"
    t.boolean  "is_lln"
    t.boolean  "is_patro"
    t.boolean  "is_kpt"
    t.boolean  "is_empty"
    t.boolean  "is_corona"
    t.boolean  "is_age"
    t.boolean  "is_champagne"
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer  "order_id"
    t.date     "delivery_date"
    t.date     "return_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "offer_id"
    t.boolean  "is_ready"
    t.boolean  "is_gone"
    t.datetime "ready_time"
    t.integer  "ready_by"
    t.datetime "gone_time"
    t.integer  "sent_by"
    t.datetime "drop_time"
    t.boolean  "dropped"
    t.integer  "dropped_by"
  end

  create_table "energies", force: :cascade do |t|
    t.decimal  "water",           precision: 8, scale: 3
    t.decimal  "gaz",             precision: 8, scale: 3
    t.decimal  "electricity",     precision: 8, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.decimal  "two_electricity", precision: 8, scale: 2
    t.decimal  "photo",           precision: 8, scale: 2
    t.decimal  "two_photo",       precision: 8, scale: 2
    t.decimal  "two_gaz",         precision: 8, scale: 3
    t.decimal  "two_water",       precision: 8, scale: 3
    t.decimal  "three_water",     precision: 8, scale: 3
    t.decimal  "four_water",      precision: 8, scale: 3
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
    t.string   "address"
    t.date     "delivery_date"
    t.date     "return_date"
    t.string   "contact"
    t.string   "phone"
    t.boolean  "is_complete"
    t.integer  "bar"
    t.integer  "beertap"
    t.boolean  "is_lln"
    t.integer  "lln_year"
    t.decimal  "deposit_event"
    t.boolean  "is_bep"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "doc_number"
    t.integer  "offer_id"
    t.integer  "client_id"
    t.boolean  "doc_invoice"
    t.boolean  "doc_credit"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.decimal  "total_htva",        precision: 12, scale: 2
    t.decimal  "total_tva",         precision: 12, scale: 2
    t.decimal  "total_tvac",        precision: 12, scale: 2
    t.boolean  "confirmation"
    t.boolean  "after_event"
    t.boolean  "confirmation_paid"
    t.boolean  "after_event_paid"
  end

  create_table "lln_imports", force: :cascade do |t|
    t.string   "circle"
    t.integer  "lln_twentyfive"
    t.integer  "lln_fifty"
    t.integer  "lln_litre"
    t.integer  "empty_box"
    t.integer  "kpt_box"
    t.integer  "return_box"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
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

  create_table "offer_articles", force: :cascade do |t|
    t.integer  "offer_id"
    t.integer  "article_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offer_boxes", force: :cascade do |t|
    t.integer  "offer_id"
    t.integer  "box_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "organizer_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "client_confirmation"
    t.boolean  "admin_confirmation"
    t.boolean  "send_email"
    t.boolean  "lln_daily"
    t.datetime "sent_at"
    t.boolean  "unforeseen_return"
    t.boolean  "lln_invoice"
    t.boolean  "confirmation_invoice"
    t.text     "comment"
  end

  create_table "parcels", force: :cascade do |t|
    t.integer  "return_box_id"
    t.integer  "box_id"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "from_wash"
    t.boolean  "from_return"
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.decimal  "wash",       precision: 8, scale: 4
    t.decimal  "handwash",   precision: 8, scale: 4
    t.decimal  "handling",   precision: 8, scale: 4
    t.decimal  "deposit",    precision: 8, scale: 4
    t.boolean  "regular"
    t.boolean  "negociated"
    t.date     "valid_from"
    t.date     "valid_till"
    t.decimal  "sell",       precision: 8, scale: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.decimal  "washing",    precision: 8, scale: 4
  end

  create_table "return_boxes", force: :cascade do |t|
    t.integer  "delivery_id"
    t.datetime "return_time"
    t.boolean  "is_back"
    t.integer  "receptionist"
    t.datetime "ctrl_time"
    t.integer  "ctrler"
    t.boolean  "is_controlled"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.date     "return_date"
    t.boolean  "wash"
    t.boolean  "send_wash"
    t.boolean  "unforeseen_return"
  end

  create_table "return_details", force: :cascade do |t|
    t.integer  "return_box_id"
    t.integer  "box_id"
    t.integer  "dirty"
    t.integer  "sealed"
    t.integer  "clean"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "dirty_ctrl"
    t.integer  "sealed_ctrl"
    t.integer  "clean_ctrl"
  end

  create_table "sorting_details", force: :cascade do |t|
    t.integer  "sorting_id"
    t.integer  "article_id"
    t.integer  "box_qtty"
    t.integer  "pile_qtty"
    t.integer  "unit_qtty"
    t.boolean  "clean"
    t.boolean  "very_dirty"
    t.boolean  "broken"
    t.boolean  "handling"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sortings", force: :cascade do |t|
    t.integer  "return_box_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "starter"
    t.integer  "ender"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
    t.string   "address"
    t.string   "postcode"
    t.string   "country"
    t.string   "vat"
    t.string   "phone"
    t.string   "gsm"
    t.string   "city"
    t.boolean  "is_lln"
    t.integer  "lln_id"
    t.boolean  "taxable"
    t.string   "company_number"
    t.boolean  "chauffeur"
    t.boolean  "interim"
    t.boolean  "fixed"
    t.boolean  "leader"
    t.integer  "time_per_week"
    t.boolean  "time_keeping"
    t.boolean  "is_namur"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "washes", force: :cascade do |t|
    t.integer  "return_box_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "washer"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "ender"
  end

end
