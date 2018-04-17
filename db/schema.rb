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

ActiveRecord::Schema.define(version: 20180417185459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_brands_on_email", unique: true
    t.index ["reset_password_token"], name: "index_brands_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follower_nodes", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_follower_nodes_on_follower_id"
    t.index ["node_id"], name: "index_follower_nodes_on_node_id"
  end

  create_table "followers", force: :cascade do |t|
    t.string "username"
    t.boolean "verified", default: false, null: false
    t.boolean "approved", default: false, null: false
    t.string "followers_count"
    t.datetime "visited_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "igid"
    t.string "json_data"
    t.datetime "parsed_at"
    t.index ["igid"], name: "index_followers_on_igid"
  end

  create_table "influencer_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "influencer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_influencer_categories_on_category_id"
    t.index ["influencer_id"], name: "index_influencer_categories_on_influencer_id"
  end

  create_table "influencer_mails", force: :cascade do |t|
    t.bigint "influencer_id"
    t.bigint "mailing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["influencer_id"], name: "index_influencer_mails_on_influencer_id"
    t.index ["mailing_id"], name: "index_influencer_mails_on_mailing_id"
  end

  create_table "influencers", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "country"
    t.integer "followers_count"
    t.integer "following_count"
    t.text "bio"
    t.integer "media_count"
    t.string "igid"
    t.string "photo"
    t.string "full_name"
    t.boolean "verified", default: false, null: false
    t.string "external_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "influencer_score"
    t.bigint "follower_id"
    t.string "ig_pic_url"
    t.string "recent_media"
    t.integer "media_score"
    t.index ["follower_id"], name: "index_influencers_on_follower_id"
  end

  create_table "mailings", force: :cascade do |t|
    t.string "content"
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.index ["brand_id"], name: "index_mailings_on_brand_id"
  end

  create_table "node_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_node_categories_on_category_id"
    t.index ["node_id"], name: "index_node_categories_on_node_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.string "name"
    t.string "followers_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "igid"
  end

  add_foreign_key "follower_nodes", "followers"
  add_foreign_key "follower_nodes", "nodes"
  add_foreign_key "influencer_categories", "categories"
  add_foreign_key "influencer_categories", "influencers"
  add_foreign_key "influencer_mails", "influencers"
  add_foreign_key "influencer_mails", "mailings"
  add_foreign_key "influencers", "followers"
  add_foreign_key "mailings", "brands"
  add_foreign_key "node_categories", "categories"
  add_foreign_key "node_categories", "nodes"
end
