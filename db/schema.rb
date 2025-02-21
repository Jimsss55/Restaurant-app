# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_03_064737) do
  create_table "customer_tables", force: :cascade do |t|
    t.integer "customer_table_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "customer_tables_customers", id: false, force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "customer_table_id", null: false
    t.index ["customer_id"], name: "index_customer_tables_customers_on_customer_id"
    t.index ["customer_table_id"], name: "index_customer_tables_customers_on_customer_table_id"
  end

  create_table "customers", force: :cascade do |t|
    t.integer "customer_table_id"
    t.string "customer_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_status"
    t.integer "payment_method", default: 0
    t.float "payment_amt"
    t.index ["customer_table_id"], name: "index_customers_on_customer_table_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "menu_items"
    t.float "menu_item_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "menu_item_id"
    t.integer "customer_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_order_items_on_customer_id"
    t.index ["menu_item_id"], name: "index_order_items_on_menu_item_id"
  end

  create_table "payment_details", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id", null: false
    t.string "journal_number"
    t.index ["customer_id"], name: "index_payment_details_on_customer_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "customer_table_id"
    t.string "customer_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_table_id"], name: "index_sessions_on_customer_table_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "payment_details", "customers"
end
