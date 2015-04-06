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

ActiveRecord::Schema.define(version: 20150406170306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "carts_products", id: false, force: :cascade do |t|
    t.integer "cart_id",    null: false
    t.integer "product_id", null: false
  end

  add_index "carts_products", ["cart_id", "product_id"], name: "index_carts_products_on_cart_id_and_product_id", using: :btree
  add_index "carts_products", ["product_id", "cart_id"], name: "index_carts_products_on_product_id_and_cart_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "orders_products", id: false, force: :cascade do |t|
    t.integer "order_id",   null: false
    t.integer "product_id", null: false
  end

  add_index "orders_products", ["order_id", "product_id"], name: "index_orders_products_on_order_id_and_product_id", using: :btree
  add_index "orders_products", ["product_id", "order_id"], name: "index_orders_products_on_product_id_and_order_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                                null: false
    t.text     "description",                         null: false
    t.decimal  "price",       precision: 8, scale: 2
    t.string   "image_url"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "password_digest", null: false
    t.string   "token",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "carts", "users"
  add_foreign_key "orders", "users"
end
