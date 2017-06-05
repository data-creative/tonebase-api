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

ActiveRecord::Schema.define(version: 20170605202049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_instruments", force: :cascade do |t|
    t.integer  "ad_id"
    t.integer  "instrument_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["ad_id"], name: "index_ad_instruments_on_ad_id", using: :btree
    t.index ["instrument_id"], name: "index_ad_instruments_on_instrument_id", using: :btree
  end

  create_table "ad_placements", force: :cascade do |t|
    t.integer  "ad_id"
    t.date     "start_date", null: false
    t.date     "end_date",   null: false
    t.integer  "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_ad_placements_on_ad_id", using: :btree
  end

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

  create_table "user_favorite_videos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "video_id"], name: "index_user_favorite_videos_on_user_id_and_video_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_favorite_videos_on_user_id", using: :btree
    t.index ["video_id"], name: "index_user_favorite_videos_on_video_id", using: :btree
  end

  create_table "user_followships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "followed_user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["followed_user_id"], name: "index_user_followships_on_followed_user_id", using: :btree
    t.index ["user_id"], name: "index_user_followships_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",          null: false
    t.string   "password",       null: false
    t.boolean  "confirmed",      null: false
    t.boolean  "visible",        null: false
    t.string   "role",           null: false
    t.string   "access_level",   null: false
    t.string   "first_name",     null: false
    t.string   "last_name",      null: false
    t.text     "bio"
    t.string   "image_url"
    t.string   "hero_url"
    t.string   "customer_uuid"
    t.boolean  "oauth"
    t.string   "oauth_provider"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["access_level"], name: "index_users_on_access_level", using: :btree
    t.index ["confirmed"], name: "index_users_on_confirmed", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["oauth"], name: "index_users_on_oauth", using: :btree
    t.index ["role"], name: "index_users_on_role", using: :btree
    t.index ["visible"], name: "index_users_on_visible", using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "instrument_id"
    t.string   "title",         null: false
    t.text     "description",   null: false
    t.text     "tags"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instrument_id"], name: "index_videos_on_instrument_id", using: :btree
    t.index ["user_id", "title"], name: "index_videos_on_user_id_and_title", unique: true, using: :btree
    t.index ["user_id"], name: "index_videos_on_user_id", using: :btree
  end

  add_foreign_key "ad_instruments", "ads"
  add_foreign_key "ad_instruments", "instruments"
  add_foreign_key "ad_placements", "ads"
  add_foreign_key "ads", "advertisers"
  add_foreign_key "user_favorite_videos", "users"
  add_foreign_key "user_favorite_videos", "videos"
  add_foreign_key "user_followships", "users"
  add_foreign_key "user_followships", "users", column: "followed_user_id"
  add_foreign_key "videos", "instruments"
  add_foreign_key "videos", "users"
end
