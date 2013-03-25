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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130325020815) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :null => false
    t.string   "commentable_type", :null => false
    t.integer  "user_id",          :null => false
    t.integer  "parent_id"
    t.text     "contents",         :null => false
    t.datetime "locked_at"
    t.text     "locked_reason"
    t.boolean  "edited"
    t.boolean  "deleted"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_type", "commentable_id"], :name => "index_comments_on_commentable"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "favs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "favable_id"
    t.string   "favable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "favs", ["favable_type", "favable_id", "user_id"], :name => "index_favs_on_favable_type_and_favable_id_and_user_id", :unique => true
  add_index "favs", ["user_id"], :name => "index_favs_on_user_id"

  create_table "forum_categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "forum_posts", :force => true do |t|
    t.string   "title"
    t.text     "contents"
    t.integer  "forum_category_id"
    t.integer  "user_id"
    t.datetime "bumped_at"
    t.boolean  "deleted"
    t.boolean  "sunk"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "forum_posts", ["bumped_at"], :name => "index_forum_posts_on_bumped_at"
  add_index "forum_posts", ["deleted"], :name => "index_forum_posts_on_deleted"
  add_index "forum_posts", ["forum_category_id"], :name => "index_forum_posts_on_forum_category_id"
  add_index "forum_posts", ["user_id"], :name => "index_forum_posts_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "to_id",      :null => false
    t.integer  "from_id",    :null => false
    t.text     "message",    :null => false
    t.boolean  "read"
    t.boolean  "reported"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messages", ["from_id"], :name => "index_messages_on_from_id"
  add_index "messages", ["reported"], :name => "index_messages_on_reported"
  add_index "messages", ["to_id"], :name => "index_messages_on_to_id"

  create_table "news_posts", :force => true do |t|
    t.string   "title",        :null => false
    t.text     "contents",     :null => false
    t.integer  "user_id",      :null => false
    t.datetime "published_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "news_posts", ["published_at"], :name => "index_news_posts_on_published_at"

  create_table "notifications", :force => true do |t|
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.integer  "user_id",         :null => false
    t.boolean  "read"
    t.string   "template",        :null => false
    t.text     "data",            :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "notifications", ["notifiable_type", "notifiable_id"], :name => "index_notifications_on_notifiable_type_and_notifiable_id"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "contents",   :null => false
    t.string   "url"
    t.integer  "user_id",    :null => false
    t.boolean  "published"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pages", ["published"], :name => "index_pages_on_published"
  add_index "pages", ["url"], :name => "index_pages_on_url"

  create_table "reports", :force => true do |t|
    t.integer  "user_id"
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.text     "reason"
    t.boolean  "resolved"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "reports", ["reportable_type", "reportable_id", "user_id"], :name => "index_reports_on_reportable_type_and_reportable_id_and_user_id", :unique => true
  add_index "reports", ["user_id"], :name => "index_reports_on_user_id"

  create_table "series", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "stories_count", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "series", ["user_id"], :name => "index_series_on_user_id"

  create_table "stories", :force => true do |t|
    t.string   "title",                          :null => false
    t.text     "contents",                       :null => false
    t.integer  "user_id",                        :null => false
    t.integer  "series_id"
    t.integer  "series_position"
    t.datetime "locked_at"
    t.text     "locked_reason"
    t.boolean  "deleted"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "word_count",      :default => 0
  end

  add_index "stories", ["deleted"], :name => "index_stories_on_deleted"
  add_index "stories", ["locked_at", "deleted"], :name => "index_stories_on_locked_at_and_deleted"
  add_index "stories", ["series_id"], :name => "index_stories_on_series_id"
  add_index "stories", ["user_id"], :name => "index_stories_on_user_id"
  add_index "stories", ["word_count"], :name => "index_stories_on_word_count"

  create_table "users", :force => true do |t|
    t.string   "name",                                   :null => false
    t.string   "tagline"
    t.text     "biography"
    t.boolean  "admin"
    t.datetime "banned_at"
    t.text     "banned_reason"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.string   "ip_address"
    t.string   "user_agent"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "watches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "watchable_id"
    t.string   "watchable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "watches", ["user_id"], :name => "index_watches_on_user_id"
  add_index "watches", ["watchable_type", "watchable_id", "user_id"], :name => "index_watches_on_watchable_type_and_watchable_id_and_user_id", :unique => true

end
