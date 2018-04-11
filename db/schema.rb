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

ActiveRecord::Schema.define(version: 20180411224733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.boolean "verified"
    t.boolean "approved"
    t.string "followers_count"
    t.datetime "parsed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "influencer_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "influencer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_influencer_categories_on_category_id"
    t.index ["influencer_id"], name: "index_influencer_categories_on_influencer_id"
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
    t.boolean "verified"
    t.string "external_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "json_data"
    t.integer "influencer_score"
    t.bigint "follower_id"
    t.index ["follower_id"], name: "index_influencers_on_follower_id"
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
  add_foreign_key "influencers", "followers"
  add_foreign_key "node_categories", "categories"
  add_foreign_key "node_categories", "nodes"
end
