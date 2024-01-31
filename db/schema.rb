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

ActiveRecord::Schema[7.1].define(version: 2024_01_31_083726) do
  create_table "actor", primary_key: "actor_id", force: :cascade do |t|
    t.string "first_name", limit: 45, null: false
    t.string "last_name", limit: 45, null: false
    t.datetime "last_update", default: -> { "datetime('now')" }
    t.index ["last_name"], name: "idx_actor_last_name"
  end

  create_table "address", primary_key: "address_id", force: :cascade do |t|
    t.string "address", limit: 50, null: false
    t.string "address2", limit: 50
    t.string "district", limit: 20, null: false
    t.integer "city_id", null: false
    t.string "postal_code", limit: 10
    t.string "phone", limit: 20, null: false
    t.datetime "last_update", precision: nil, null: false
    t.index ["city_id"], name: "idx_fk_city_id"
  end

  create_table "category", primary_key: "category_id", force: :cascade do |t|
    t.string "name", limit: 25, null: false
    t.datetime "last_update", precision: nil, null: false
  end

  create_table "city", primary_key: "city_id", force: :cascade do |t|
    t.string "city", limit: 50, null: false
    t.integer "country_id", null: false
    t.datetime "last_update", precision: nil, null: false
    t.index ["country_id"], name: "idx_fk_country_id"
  end

  create_table "country", primary_key: "country_id", force: :cascade do |t|
    t.string "country", limit: 50, null: false
    t.datetime "last_update", precision: nil
  end

  create_table "customer", primary_key: "customer_id", force: :cascade do |t|
    t.integer "store_id", null: false
    t.string "first_name", limit: 45, null: false
    t.string "last_name", limit: 45, null: false
    t.string "email", limit: 50
    t.integer "address_id", null: false
    t.string "active", limit: 1, default: "Y", null: false
    t.datetime "create_date", precision: nil, null: false
    t.datetime "last_update", precision: nil, null: false
    t.index ["address_id"], name: "idx_customer_fk_address_id"
    t.index ["last_name"], name: "idx_customer_last_name"
    t.index ["store_id"], name: "idx_customer_fk_store_id"
  end

  create_table "film", primary_key: "film_id", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.binary "description"
    t.string "release_year", limit: 4
    t.integer "language_id", null: false
    t.integer "original_language_id"
    t.integer "rental_duration", default: 3, null: false
    t.decimal "rental_rate", precision: 4, scale: 2, default: "4.99", null: false
    t.integer "length"
    t.decimal "replacement_cost", precision: 5, scale: 2, default: "19.99", null: false
    t.string "rating", limit: 10, default: "G"
    t.string "special_features", limit: 100
    t.datetime "last_update", default: -> { "datetime('now')" }
    t.index ["language_id"], name: "idx_fk_language_id"
    t.index ["original_language_id"], name: "idx_fk_original_language_id"
  end

  create_table "film_actor", primary_key: ["actor_id", "film_id"], force: :cascade do |t|
    t.integer "actor_id", null: false
    t.integer "film_id", null: false
    t.datetime "last_update", precision: nil, null: false
    t.index ["actor_id"], name: "idx_fk_film_actor_actor"
    t.index ["film_id"], name: "idx_fk_film_actor_film"
  end

  create_table "film_category", primary_key: ["film_id", "category_id"], force: :cascade do |t|
    t.integer "film_id", null: false
    t.integer "category_id", null: false
    t.datetime "last_update", precision: nil, null: false
    t.index ["category_id"], name: "idx_fk_film_category_category"
    t.index ["film_id"], name: "idx_fk_film_category_film"
  end

  create_table "film_text", primary_key: "film_id", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.binary "description"
  end

  create_table "inventory", primary_key: "inventory_id", force: :cascade do |t|
    t.integer "film_id", null: false
    t.integer "store_id", null: false
    t.datetime "last_update", precision: nil, null: false
    t.index ["film_id"], name: "idx_fk_film_id"
    t.index ["store_id", "film_id"], name: "idx_fk_film_id_store_id"
  end

  create_table "language", primary_key: "language_id", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.datetime "last_update", precision: nil, null: false
  end

  create_table "payment", primary_key: "payment_id", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "staff_id", null: false
    t.integer "rental_id"
    t.decimal "amount", precision: 5, scale: 2, null: false
    t.datetime "payment_date", precision: nil, null: false
    t.datetime "last_update", precision: nil, null: false
    t.index ["customer_id"], name: "idx_fk_customer_id"
    t.index ["staff_id"], name: "idx_fk_staff_id"
  end

  create_table "rental", primary_key: "rental_id", force: :cascade do |t|
    t.datetime "rental_date", precision: nil, null: false
    t.integer "inventory_id", null: false
    t.integer "customer_id", null: false
    t.datetime "return_date", precision: nil
    t.integer "staff_id", null: false
    t.datetime "last_update", precision: nil, null: false
    t.index ["customer_id"], name: "idx_rental_fk_customer_id"
    t.index ["inventory_id"], name: "idx_rental_fk_inventory_id"
    t.index ["rental_date", "inventory_id", "customer_id"], name: "idx_rental_uq", unique: true
    t.index ["staff_id"], name: "idx_rental_fk_staff_id"
  end

  create_table "staff", primary_key: "staff_id", force: :cascade do |t|
    t.string "first_name", limit: 45, null: false
    t.string "last_name", limit: 45, null: false
    t.integer "address_id", null: false
    t.binary "picture"
    t.string "email", limit: 50
    t.integer "store_id", null: false
    t.integer "active", default: 1, null: false
    t.string "username", limit: 16, null: false
    t.string "password", limit: 40
    t.datetime "last_update", precision: nil, null: false
    t.index ["address_id"], name: "idx_fk_staff_address_id"
    t.index ["store_id"], name: "idx_fk_staff_store_id"
  end

  create_table "store", primary_key: "store_id", force: :cascade do |t|
    t.integer "manager_staff_id", null: false
    t.integer "address_id", null: false
    t.datetime "last_update", precision: nil, null: false
    t.index ["address_id"], name: "idx_fk_store_address"
    t.index ["manager_staff_id"], name: "idx_store_fk_manager_staff_id"
  end

  add_foreign_key "address", "city", primary_key: "city_id", on_update: :cascade
  add_foreign_key "city", "country", primary_key: "country_id", on_update: :cascade
  add_foreign_key "customer", "address", primary_key: "address_id", on_update: :cascade
  add_foreign_key "customer", "store", primary_key: "store_id", on_update: :cascade
  add_foreign_key "film", "language", column: "original_language_id", primary_key: "language_id"
  add_foreign_key "film", "language", primary_key: "language_id"
  add_foreign_key "film_actor", "actor", primary_key: "actor_id", on_update: :cascade
  add_foreign_key "film_actor", "film", primary_key: "film_id", on_update: :cascade
  add_foreign_key "film_category", "category", primary_key: "category_id", on_update: :cascade
  add_foreign_key "film_category", "film", primary_key: "film_id", on_update: :cascade
  add_foreign_key "inventory", "film", primary_key: "film_id", on_update: :cascade
  add_foreign_key "inventory", "store", primary_key: "store_id", on_update: :cascade
  add_foreign_key "payment", "customer", primary_key: "customer_id"
  add_foreign_key "payment", "rental", primary_key: "rental_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "payment", "staff", primary_key: "staff_id"
  add_foreign_key "rental", "customer", primary_key: "customer_id"
  add_foreign_key "rental", "inventory", primary_key: "inventory_id"
  add_foreign_key "rental", "staff", primary_key: "staff_id"
  add_foreign_key "staff", "address", primary_key: "address_id", on_update: :cascade
  add_foreign_key "staff", "store", primary_key: "store_id", on_update: :cascade
  add_foreign_key "store", "address", primary_key: "address_id"
  add_foreign_key "store", "staff", column: "manager_staff_id", primary_key: "staff_id"
end
