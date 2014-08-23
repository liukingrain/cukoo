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

ActiveRecord::Schema.define(version: 20140823115859) do

  create_table "addresses", force: true do |t|
    t.string   "city"
    t.string   "postal_code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
    t.string   "company_name"
    t.string   "company_nip"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street_and_number"
  end

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "bedclothes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_items", force: true do |t|
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_size"
  end

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "step"
    t.string   "shipping_address_id"
    t.string   "shipping_method"
    t.string   "payment_method"
    t.integer  "billing_address_id"
    t.boolean  "invoice"
    t.boolean  "custom_billing_address"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "locked_at"
  end

  create_table "order_items", force: true do |t|
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "order_id"
    t.integer  "quantity"
    t.string   "product_name"
    t.float    "product_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "cart_id"
    t.string   "email"
    t.string   "status"
    t.integer  "shipping_address_id"
    t.string   "shipping_method"
    t.float    "shipping_price"
    t.string   "payment_method"
    t.string   "auth_token"
    t.integer  "billing_address_id"
    t.text     "comment"
    t.boolean  "invoice"
    t.boolean  "custom_billing_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_statuses", force: true do |t|
    t.string   "status"
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.float    "amount"
    t.string   "method"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.string   "full_view"
    t.string   "zoom"
    t.string   "pattern"
    t.string   "pattern_thumb"
    t.string   "zoom_thumb"
    t.string   "full_view_thumb"
  end

  create_table "pillows", force: true do |t|
    t.string   "size"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_sizes", force: true do |t|
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_types", force: true do |t|
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "amount"
    t.string   "fabric"
    t.string   "manufacturer"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.boolean  "bargain"
    t.integer  "size_id"
    t.integer  "type_id"
    t.boolean  "bestseller"
  end

  create_table "shipping_rates", force: true do |t|
    t.string   "shipping_method"
    t.float    "rate"
    t.float    "free_of_charge_treshold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
