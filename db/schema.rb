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

ActiveRecord::Schema.define(version: 20170415151649) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters",     limit: 65535
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "bentuks", primary_key: "bentuk_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "bentuk_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "distances", primary_key: ["origin_id", "destination_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "origin_id",                 null: false
    t.integer  "destination_id",            null: false
    t.float    "distance",       limit: 53
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["destination_id"], name: "fk_distances_outlets2_idx", using: :btree
    t.index ["origin_id"], name: "fk_distances_outlets1_idx", using: :btree
  end

  create_table "dtrans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "stock_id"
    t.integer "transaksi_id"
    t.integer "dta_qty"
    t.integer "dtd_qty"
    t.integer "dtt_qty"
    t.string  "dtd_rsn"
    t.string  "dtt_rsn"
  end

  create_table "indications", primary_key: "indication_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "indication_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "kemasans", primary_key: "kemasan_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "kemasan_kode"
    t.string   "kemasan_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "obats", primary_key: "obat_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "obat_name"
    t.integer  "obat_hpp"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "kemasan_id"
    t.integer  "bentuk_id"
    t.integer  "indication_id"
    t.index ["bentuk_id"], name: "fk_rails_e496e91834", using: :btree
    t.index ["indication_id"], name: "fk_rails_461ef4225c", using: :btree
    t.index ["kemasan_id"], name: "fk_rails_4854e80013", using: :btree
  end

  create_table "outlet_types", primary_key: "otype_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "otype_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outlets", primary_key: "outlet_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "otype_id",       null: false
    t.string   "outlet_name"
    t.string   "outlet_address"
    t.string   "outlet_phone"
    t.string   "outlet_city"
    t.string   "outlet_email"
    t.string   "outlet_fax"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["otype_id"], name: "fk_outlets_outlet_types1_idx", using: :btree
  end

  create_table "roles", primary_key: "role_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "role_name",  limit: 45
    t.string   "role_desc",  limit: 300
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "safety_stocks", primary_key: ["ss_period_id", "stock_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "ss_period_id",     null: false
    t.integer  "stock_id",         null: false
    t.integer  "safety_stock_qty"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["ss_period_id"], name: "fk_safety_stocks_ss_periods1_idx", using: :btree
    t.index ["stock_id"], name: "fk_safety_stocks_stocks1_idx", using: :btree
  end

  create_table "ss_periods", primary_key: "ss_period_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "ss_period_period"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "stocks", primary_key: "stock_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "obat_id"
    t.integer  "outlet_id"
    t.integer  "stok_qty"
    t.integer  "current_ss"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["obat_id"], name: "fk_stocks_obats1_idx", using: :btree
    t.index ["outlet_id"], name: "fk_stocks_outlets1_idx", using: :btree
  end

  create_table "transaksis", primary_key: "transaksi_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "trans_status"
    t.datetime "asked_at"
    t.datetime "dropped_at"
    t.datetime "accepted_at"
  end

  create_table "users", primary_key: "user_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "role_id",                                        null: false
    t.integer  "outlet_id",                                      null: false
    t.string   "user_name",              limit: 45
    t.string   "user_fullname",          limit: 45
    t.string   "user_address",           limit: 45
    t.string   "user_phone",             limit: 45
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["outlet_id"], name: "fk_users_outlets1_idx", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "fk_users_roles1_idx", using: :btree
  end

  add_foreign_key "distances", "outlets", column: "destination_id", primary_key: "outlet_id", name: "fk_distances_outlets2"
  add_foreign_key "distances", "outlets", column: "origin_id", primary_key: "outlet_id", name: "fk_distances_outlets1"
  add_foreign_key "obats", "bentuks", primary_key: "bentuk_id"
  add_foreign_key "obats", "indications", primary_key: "indication_id"
  add_foreign_key "obats", "kemasans", primary_key: "kemasan_id"
  add_foreign_key "outlets", "outlet_types", column: "otype_id", primary_key: "otype_id", name: "fk_outlets_outlet_types1"
  add_foreign_key "safety_stocks", "ss_periods", primary_key: "ss_period_id", name: "fk_safety_stocks_ss_periods1"
  add_foreign_key "safety_stocks", "stocks", primary_key: "stock_id", name: "fk_safety_stocks_stocks1"
  add_foreign_key "stocks", "obats", primary_key: "obat_id", name: "fk_stocks_obats1"
  add_foreign_key "stocks", "outlets", primary_key: "outlet_id", name: "fk_stocks_outlets1"
  add_foreign_key "users", "outlets", primary_key: "outlet_id", name: "fk_users_outlets1"
  add_foreign_key "users", "roles", primary_key: "role_id", name: "fk_users_roles1"
end
