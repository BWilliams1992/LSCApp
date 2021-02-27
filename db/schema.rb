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

ActiveRecord::Schema.define(version: 2021_02_27_162142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "clean_requests", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "clean_type"
    t.text "notes"
    t.date "date"
    t.bigint "location_id"
    t.string "plot_number"
    t.boolean "approved", default: false
    t.index ["location_id"], name: "index_clean_requests_on_location_id"
    t.index ["user_id"], name: "index_clean_requests_on_user_id"
  end

  create_table "cleans", force: :cascade do |t|
    t.date "date"
    t.bigint "location_id"
    t.boolean "completed"
    t.string "clean_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "plot_id"
    t.bigint "clean_request_id"
    t.time "start_time"
    t.time "end_time"
    t.integer "num_people"
    t.index ["clean_request_id"], name: "index_cleans_on_clean_request_id"
    t.index ["location_id"], name: "index_cleans_on_location_id"
    t.index ["plot_id"], name: "index_cleans_on_plot_id"
  end

  create_table "cost_house_locations", force: :cascade do |t|
    t.bigint "house_id"
    t.bigint "location_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "sparkle_cost"
    t.float "demo_cost"
    t.float "pre_paint_cost"
    t.float "post_paint_cost"
    t.index ["house_id"], name: "index_cost_house_locations_on_house_id"
    t.index ["location_id"], name: "index_cost_house_locations_on_location_id"
  end

  create_table "extras", force: :cascade do |t|
    t.string "name"
    t.float "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "sales_name"
    t.string "build_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "cost_house_locations_id"
    t.integer "bedrooms"
    t.index ["cost_house_locations_id"], name: "index_houses_on_cost_house_locations_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "start_date"
    t.date "end_date"
    t.bigint "location_id", null: false
    t.index ["location_id"], name: "index_invoices_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "county"
    t.string "postcode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "site_name"
    t.integer "number_of_plots"
    t.date "start_date"
    t.bigint "cost_house_locations_id"
    t.float "vo_cost"
    t.index ["cost_house_locations_id"], name: "index_locations_on_cost_house_locations_id"
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "plot_extras", force: :cascade do |t|
    t.bigint "plot_id"
    t.bigint "extra_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["extra_id"], name: "index_plot_extras_on_extra_id"
    t.index ["plot_id"], name: "index_plot_extras_on_plot_id"
  end

  create_table "plots", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number"
    t.bigint "house_id"
    t.index ["house_id"], name: "index_plots_on_house_id"
    t.index ["location_id"], name: "index_plots_on_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin"
    t.string "name"
    t.string "access_token"
    t.datetime "expires_at"
    t.string "refresh_token"
    t.boolean "staff"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clean_requests", "locations"
  add_foreign_key "clean_requests", "users"
  add_foreign_key "cleans", "clean_requests"
  add_foreign_key "cleans", "locations"
  add_foreign_key "cleans", "plots"
  add_foreign_key "houses", "cost_house_locations", column: "cost_house_locations_id"
  add_foreign_key "invoices", "locations"
  add_foreign_key "locations", "cost_house_locations", column: "cost_house_locations_id"
  add_foreign_key "locations", "users"
  add_foreign_key "plots", "houses"
  add_foreign_key "plots", "locations"
end
