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

ActiveRecord::Schema.define(version: 20150823103622) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "action",          limit: 255
    t.integer  "trackable_id",    limit: 4
    t.string   "trackable_type",  limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "read",            limit: 1,   default: false
    t.integer  "user_tracked_id", limit: 4
  end

  add_index "activities", ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "article_tags", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.integer  "tag_id",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "article_translations", force: :cascade do |t|
    t.integer  "article_id",  limit: 4,     null: false
    t.string   "locale",      limit: 255,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "title",       limit: 255
    t.text     "content",     limit: 65535
    t.text     "description", limit: 65535
  end

  add_index "article_translations", ["article_id"], name: "index_article_translations_on_article_id", using: :btree
  add_index "article_translations", ["locale"], name: "index_article_translations_on_locale", using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer  "language_id",    limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id",        limit: 4
    t.string   "slug",           limit: 255
    t.boolean  "status",         limit: 1
    t.datetime "publish_date"
    t.integer  "comments_count", limit: 4,   default: 0, null: false
  end

  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content",          limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "ancestry",         limit: 255
    t.integer  "user_id",          limit: 4
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "page_translations", force: :cascade do |t|
    t.integer  "page_id",    limit: 4,     null: false
    t.string   "locale",     limit: 255,   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "about",      limit: 65535
  end

  add_index "page_translations", ["locale"], name: "index_page_translations_on_locale", using: :btree
  add_index "page_translations", ["page_id"], name: "index_page_translations_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "ff_link",    limit: 255
    t.string   "tw_link",    limit: 255
    t.string   "yt_link",    limit: 255
  end

  create_table "question_tags", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.integer  "tag_id",      limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "content",        limit: 65535
    t.string   "title",          limit: 255
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "slug",           limit: 255
    t.integer  "comments_count", limit: 4,     default: 0, null: false
  end

  add_index "questions", ["slug"], name: "index_questions_on_slug", unique: true, using: :btree

  create_table "snippet_translations", force: :cascade do |t|
    t.integer  "snippet_id", limit: 4,     null: false
    t.string   "locale",     limit: 255,   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "content",    limit: 65535
  end

  add_index "snippet_translations", ["locale"], name: "index_snippet_translations_on_locale", using: :btree
  add_index "snippet_translations", ["snippet_id"], name: "index_snippet_translations_on_snippet_id", using: :btree

  create_table "snippets", force: :cascade do |t|
    t.integer  "video_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "tag_translations", force: :cascade do |t|
    t.integer  "tag_id",     limit: 4,   null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
  end

  add_index "tag_translations", ["locale"], name: "index_tag_translations_on_locale", using: :btree
  add_index "tag_translations", ["tag_id"], name: "index_tag_translations_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
    t.string   "slug",       limit: 255
  end

  add_index "tags", ["slug"], name: "index_tags_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "role",                   limit: 4
    t.string   "name",                   limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "uid",                    limit: 255
    t.string   "provider",               limit: 255
    t.string   "url",                    limit: 255
    t.string   "slug",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "video_tags", force: :cascade do |t|
    t.integer  "video_id",   limit: 4
    t.integer  "tag_id",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "video_translations", force: :cascade do |t|
    t.integer  "video_id",    limit: 4,     null: false
    t.string   "locale",      limit: 255,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
  end

  add_index "video_translations", ["locale"], name: "index_video_translations_on_locale", using: :btree
  add_index "video_translations", ["video_id"], name: "index_video_translations_on_video_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "file_link",      limit: 255
    t.integer  "duration",       limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "image",          limit: 255
    t.integer  "user_id",        limit: 4
    t.string   "slug",           limit: 255
    t.boolean  "status",         limit: 1
    t.datetime "publish_date"
    t.integer  "comments_count", limit: 4,   default: 0, null: false
  end

  add_index "videos", ["slug"], name: "index_videos_on_slug", unique: true, using: :btree

  add_foreign_key "activities", "users"
end
