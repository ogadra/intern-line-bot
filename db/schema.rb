# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_19_064555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tickets", force: :cascade do |t|
    t.string "code", null: false
    t.integer "brand_id", null: false
    t.integer "item_id", null: false
    t.string "url", null: false
    t.string "status", default: "issued", null: false
    t.integer "issued_at", null: false
    t.integer "exchanged_at"
    t.string "line_user_id", null: false
    t.index ["code"], name: "index_tickets_on_code", unique: true
    t.index ["url"], name: "index_tickets_on_url", unique: true
  end

  create_table "users", primary_key: "line_user_id", id: :string, force: :cascade do |t|
    t.datetime "friend_registration_datetime", null: false
    t.boolean "is_blocked", default: false, null: false
    t.index ["line_user_id"], name: "index_users_on_line_user_id", unique: true
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tickets", "users", column: "line_user_id", primary_key: "line_user_id"
end
