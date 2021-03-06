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

ActiveRecord::Schema.define(version: 20151010023138) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "commenter"
    t.text     "comment"
    t.integer  "post_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "favorite_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorite_posts", ["post_id"], name: "index_favorite_posts_on_post_id"
  add_index "favorite_posts", ["user_id"], name: "index_favorite_posts_on_user_id"

  create_table "pictures", force: :cascade do |t|
    t.string   "image"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "post_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "pictures", ["post_id"], name: "index_pictures_on_post_id"

  create_table "post_categoryships", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "post_categoryships", ["category_id"], name: "index_post_categoryships_on_category_id"
  add_index "post_categoryships", ["post_id"], name: "index_post_categoryships_on_post_id"

  create_table "posts", force: :cascade do |t|
    t.string   "topic"
    t.text     "content"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "comments_count"
    t.datetime "last_comment"
    t.integer  "user_id"
    t.string   "status"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "liked_users_count",      default: 0
    t.integer  "subscribed_users_count", default: 0
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "profiles", force: :cascade do |t|
    t.text    "bio"
    t.integer "user_id"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["post_id"], name: "index_taggings_on_post_id"
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "taggings_count", default: 0
  end

  create_table "taipei_parks", force: :cascade do |t|
    t.integer  "park_id"
    t.string   "name"
    t.string   "administrativearea"
    t.string   "location"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "user_post_likeships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_post_likeships", ["post_id"], name: "index_user_post_likeships_on_post_id"
  add_index "user_post_likeships", ["user_id"], name: "index_user_post_likeships_on_user_id"

  create_table "user_post_subscribeships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_post_subscribeships", ["post_id"], name: "index_user_post_subscribeships_on_post_id"
  add_index "user_post_subscribeships", ["user_id"], name: "index_user_post_subscribeships_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "role"
    t.string   "fb_uid"
    t.string   "fb_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
