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

ActiveRecord::Schema.define(version: 20170521115324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "layouts", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "size"
    t.string   "plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json     "pictures"
    t.index ["project_id"], name: "index_layouts_on_project_id", using: :btree
  end

  create_table "models", force: :cascade do |t|
    t.string   "package"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_models_on_project_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.text     "description"
    t.integer  "album_id"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["album_id"], name: "index_pictures_on_album_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "unit_no"
    t.float    "net_value"
    t.integer  "model_id"
    t.integer  "layout_id"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["layout_id"], name: "index_units_on_layout_id", using: :btree
    t.index ["model_id"], name: "index_units_on_model_id", using: :btree
    t.index ["project_id"], name: "index_units_on_project_id", using: :btree
    t.index ["user_id"], name: "index_units_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "title"
    t.string   "name"
    t.string   "mobile_no"
    t.string   "address"
    t.date     "birthday"
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

end
