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

ActiveRecord::Schema.define(version: 20131101101102) do

  create_table "area_details", force: true do |t|
    t.integer "area_id", limit: 3, null: false
    t.integer "shop_id", limit: 3, null: false
  end

  create_table "areas", force: true do |t|
    t.string  "code",       limit: 63,  null: false
    t.string  "name",       limit: 127, null: false
    t.integer "soat_order", limit: 3,   null: false
    t.string  "bg_color",   limit: 6
    t.string  "color",      limit: 6
    t.integer "level",      limit: 2
  end

  create_table "customer_messages", force: true do |t|
    t.string   "mail_addr",     limit: 254, null: false
    t.string   "name",          limit: 127, null: false
    t.integer  "age"
    t.binary   "sex",           limit: 1
    t.string   "address",       limit: 254
    t.string   "phone",         limit: 31
    t.string   "ip_addr",       limit: 31,  null: false
    t.string   "region",        limit: 63
    t.integer  "shop_code"
    t.date     "visit_date"
    t.time     "visit_time"
    t.integer  "repetition"
    t.integer  "menu_code"
    t.integer  "q",             limit: 1
    t.integer  "s",             limit: 1
    t.integer  "c",             limit: 1
    t.integer  "a",             limit: 1
    t.binary   "reply",         limit: 1,   null: false
    t.text     "message"
    t.datetime "received_time",             null: false
  end

  create_table "customer_messages2", force: true do |t|
    t.string   "mail_addr",  limit: 63,  null: false
    t.string   "name",       limit: 32,  null: false
    t.integer  "age"
    t.boolean  "male"
    t.string   "address",    limit: 127
    t.string   "phone",      limit: 63
    t.string   "ip_addr",    limit: 15,  null: false
    t.float    "lat"
    t.float    "lng"
    t.string   "region"
    t.integer  "shop_id"
    t.date     "visit_time"
    t.integer  "repetition"
    t.integer  "menu_id"
    t.integer  "q"
    t.integer  "s"
    t.integer  "c"
    t.integer  "a"
    t.boolean  "reply",                  null: false
    t.text     "message",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", force: true do |t|
    t.string   "mail_addr",  limit: 63,                  null: false
    t.string   "name",       limit: 32,                  null: false
    t.integer  "age"
    t.boolean  "male"
    t.string   "address",    limit: 127
    t.string   "phone",      limit: 63
    t.string   "ip_addr",    limit: 15,                  null: false
    t.float    "lat"
    t.float    "lng"
    t.string   "region"
    t.integer  "shop_id"
    t.date     "visit_date"
    t.integer  "visit_time"
    t.integer  "repetition"
    t.integer  "menu_id"
    t.integer  "q"
    t.integer  "s"
    t.integer  "c"
    t.integer  "a"
    t.boolean  "reply",                                  null: false
    t.text     "message",                                null: false
    t.boolean  "mail_sent",              default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.string  "name",              limit: 63, null: false
    t.integer "soat",                         null: false
    t.text    "comment",                      null: false
    t.integer "page",                         null: false
    t.binary  "for_questionnaire", limit: 1,  null: false
  end

  create_table "ir_messages", force: true do |t|
    t.string   "name",           limit: 63,  null: false
    t.string   "name_f",         limit: 127, null: false
    t.string   "company_name",   limit: 63
    t.string   "company_name_f", limit: 127
    t.string   "mail_addr",      limit: 127, null: false
    t.string   "address"
    t.string   "phone",          limit: 63
    t.text     "message"
    t.datetime "received_time",              null: false
  end

  create_table "ir_messages2", force: true do |t|
    t.string   "name",           limit: 63,                  null: false
    t.string   "name_f",         limit: 63
    t.string   "company_name",   limit: 127
    t.string   "company_name_f", limit: 127
    t.string   "address",        limit: 127
    t.string   "phone",          limit: 32
    t.string   "mail_addr",      limit: 63
    t.string   "message"
    t.boolean  "mail_sent",                  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "name",           limit: 127,                                 null: false
    t.datetime "sell_from",                  default: '1985-01-01 00:00:00', null: false
    t.datetime "sell_to",                    default: '2099-12-31 00:00:00', null: false
    t.datetime "promotion_from"
    t.datetime "promotion_to"
    t.integer  "price",                                                      null: false
    t.text     "comment"
    t.integer  "genre_id",                                                   null: false
    t.string   "canpaign_page",  limit: 31
    t.integer  "push_priority"
  end

  create_table "news_releases", force: true do |t|
    t.integer  "news_type",    limit: 2,   null: false
    t.datetime "release_date",             null: false
    t.string   "title",        limit: 127, null: false
    t.string   "url"
    t.string   "news_code",    limit: 31
  end

  create_table "prefs", force: true do |t|
    t.integer "priority",  limit: 1,   default: 0,  null: false
    t.integer "area_code", limit: 1,                null: false
    t.string  "area_name", limit: 127,              null: false
    t.string  "name",      limit: 63,  default: "", null: false
  end

  add_index "prefs", ["area_code"], name: "area_code", using: :btree
  add_index "prefs", ["priority"], name: "priority", using: :btree

  create_table "receives", force: true do |t|
    t.integer "shop_code",                                         null: false
    t.date    "target_date",                                       null: false
    t.decimal "nyukin",                   precision: 10, scale: 0, null: false
    t.string  "yokin_keitai", limit: 63
    t.string  "bikou",        limit: 127
  end

  create_table "recruit_entries", force: true do |t|
    t.string   "name",       limit: 63,                        null: false
    t.binary   "sex",        limit: 1,                         null: false
    t.integer  "age",                                          null: false
    t.string   "zip",        limit: 15
    t.string   "address",    limit: 127,                       null: false
    t.string   "phone",      limit: 63,                        null: false
    t.string   "mail_addr",  limit: 127,                       null: false
    t.integer  "shop_id",                                      null: false
    t.string   "work_style", limit: 0,   default: "パート・アルバイト", null: false
    t.text     "message"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "recruits", force: true do |t|
    t.integer  "shop_id",                null: false
    t.datetime "offer_from",             null: false
    t.datetime "offer_to",               null: false
    t.integer  "wage_from",  limit: 2,   null: false
    t.integer  "wage_to",    limit: 2,   null: false
    t.string   "comment",    limit: 254, null: false
  end

  add_index "recruits", ["shop_id", "offer_from", "offer_to"], name: "Index_2", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "shops", force: true do |t|
    t.integer "pref_code",           limit: 1,                             default: 0,     null: false
    t.integer "route_code",          limit: 1,                             default: 0,     null: false
    t.string  "name",                limit: 63,                            default: "",    null: false
    t.string  "furigana",            limit: 127
    t.string  "zip",                 limit: 8
    t.string  "address",                                                   default: "",    null: false
    t.string  "phone",               limit: 63,                            default: "",    null: false
    t.string  "shop_hour",           limit: 127
    t.string  "shop_hour_comment",   limit: 127
    t.date    "inauguration",                                                              null: false
    t.date    "close",                                                                     null: false
    t.boolean "allnight",                                                  default: false, null: false
    t.boolean "boxsheet",                                                  default: false, null: false
    t.boolean "truckpark",                                                 default: false, null: false
    t.decimal "lat",                             precision: 13, scale: 10
    t.decimal "lng",                             precision: 13, scale: 10
    t.integer "zoom",                                                      default: 0,     null: false
    t.string  "map_qr_image_name",   limit: 127
    t.string  "entry_qr_image_name", limit: 127
    t.string  "map_image_name",      limit: 127
    t.string  "access",                                                    default: "",    null: false
    t.string  "staff_image",         limit: 63
    t.string  "staff_title",         limit: 63
    t.text    "staff_message"
    t.string  "landmark",            limit: 254
  end

  add_index "shops", ["address", "phone"], name: "manager_code", unique: true, using: :btree
  add_index "shops", ["pref_code", "name", "inauguration", "close"], name: "pref_code", using: :btree

  create_table "sites", force: true do |t|
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "name",          limit: 127, null: false
    t.string   "controller",    limit: 31,  null: false
    t.string   "action",        limit: 31,  null: false
    t.float    "priority",                  null: false
    t.string   "description",   limit: 254
    t.string   "keywords",      limit: 254
    t.datetime "last_modified"
    t.string   "change_freq",   limit: 15,  null: false
    t.integer  "item_id"
    t.integer  "menu_page"
  end

  add_index "sites", ["parent_id", "lft", "rgt"], name: "lrp_idx", using: :btree
  add_index "sites", ["parent_id"], name: "p_idx", using: :btree

end
