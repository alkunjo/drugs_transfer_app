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

ActiveRecord::Schema.define(version: 20170212102037) do

  create_table "distances", primary_key: ["origin_id", "destination_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "origin_id",      null: false
    t.integer  "destination_id", null: false
    t.integer  "distance"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["destination_id"], name: "fk_distances_outlets2_idx", using: :btree
    t.index ["origin_id"], name: "fk_distances_outlets1_idx", using: :btree
  end

  create_table "dtrans", primary_key: ["stock_id", "transaksi_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "stock_id",     null: false
    t.integer  "transaksi_id", null: false
    t.integer  "dta_qty"
    t.integer  "dtd_qty"
    t.integer  "dtt_qty"
    t.string   "dt_rsn"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["transaksi_id"], name: "fk_dtrans_transaksis1_idx", using: :btree
  end

  create_table "obats", primary_key: "obat_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "obat_name"
    t.integer  "obat_hpp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["stock_id"], name: "fk_safety_stocks_stocks1_idx", using: :btree
  end

  create_table "satuans", primary_key: "satuan_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "satuan_code",   limit: 45
    t.string   "satuan_ukuran", limit: 45
    t.integer  "satuan_isi"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "ss_periods", primary_key: "ss_period_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "ss_period_period"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "stocks", primary_key: "stock_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "satuan_id"
    t.integer  "obat_id"
    t.integer  "outlet_id"
    t.integer  "stok_qty"
    t.integer  "current_ss"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["obat_id"], name: "fk_stocks_obats1_idx", using: :btree
    t.index ["outlet_id"], name: "fk_stocks_outlets1_idx", using: :btree
    t.index ["satuan_id"], name: "fk_stocks_satuans1_idx", using: :btree
  end

  create_table "transaksis", primary_key: "transaksi_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "receiver_id",  null: false
    t.integer  "sender_id",    null: false
    t.integer  "trans_status"
    t.datetime "asked_at"
    t.datetime "dropped_at"
    t.datetime "accepted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["receiver_id"], name: "fk_transaksis_outlets2_idx", using: :btree
    t.index ["sender_id"], name: "fk_transaksis_outlets1_idx", using: :btree
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
  add_foreign_key "dtrans", "stocks", primary_key: "stock_id", name: "fk_dtrans_stocks1"
  add_foreign_key "dtrans", "transaksis", primary_key: "transaksi_id", name: "fk_dtrans_transaksis1"
  add_foreign_key "outlets", "outlet_types", column: "otype_id", primary_key: "otype_id", name: "fk_outlets_outlet_types1"
  add_foreign_key "safety_stocks", "ss_periods", primary_key: "ss_period_id", name: "fk_safety_stocks_ss_periods1"
  add_foreign_key "safety_stocks", "stocks", primary_key: "stock_id", name: "fk_safety_stocks_stocks1"
  add_foreign_key "stocks", "obats", primary_key: "obat_id", name: "fk_stocks_obats1"
  add_foreign_key "stocks", "outlets", primary_key: "outlet_id", name: "fk_stocks_outlets1"
  add_foreign_key "stocks", "satuans", primary_key: "satuan_id", name: "fk_stocks_satuans1"
  add_foreign_key "transaksis", "outlets", column: "receiver_id", primary_key: "outlet_id", name: "fk_transaksis_outlets2"
  add_foreign_key "transaksis", "outlets", column: "sender_id", primary_key: "outlet_id", name: "fk_transaksis_outlets1"
  add_foreign_key "users", "outlets", primary_key: "outlet_id", name: "fk_users_outlets1"
  add_foreign_key "users", "roles", primary_key: "role_id", name: "fk_users_roles1"
end
