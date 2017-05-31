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

ActiveRecord::Schema.define(version: 20170531221454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", force: :cascade do |t|
    t.integer  "advertiser_id"
    t.string   "title",         null: false
    t.text     "content"
    t.string   "url"
    t.string   "image_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["advertiser_id"], name: "index_ads_on_advertiser_id", using: :btree
  end

  create_table "advertisers", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.string   "url"
    t.text     "metadata"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_advertisers_on_name", unique: true, using: :btree
  end

  create_table "instruments", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_instruments_on_name", unique: true, using: :btree
  end

  add_foreign_key "ads", "advertisers"
end
