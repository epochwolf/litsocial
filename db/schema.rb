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

ActiveRecord::Schema.define(:version => 20120603013143) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
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

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_stories", :force => true do |t|
    t.integer "category_id"
    t.integer "story_id"
  end

  add_index "categories_stories", ["category_id", "story_id"], :name => "index_categories_stories_on_category_id_and_story_id", :unique => true

  create_table "comments", :force => true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "position"
    t.integer  "parent_id"
    t.integer  "reply_count"
    t.integer  "user_id"
    t.text     "contents"
    t.boolean  "edited"
    t.boolean  "deleted"
    t.text     "deleted_reason"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_type", "commentable_id", "deleted"], :name => "index_comments_on_commentable"
  add_index "comments", ["parent_id", "position"], :name => "index_comments_on_parent_id_and_position"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "messages", :force => true do |t|
    t.text     "contents",                          :null => false
    t.integer  "from_id",                           :null => false
    t.boolean  "flagged",        :default => false, :null => false
    t.boolean  "deleted",        :default => false, :null => false
    t.text     "deleted_reason", :default => "",    :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "messages", ["deleted", "created_at"], :name => "index_messages_to_deleted"
  add_index "messages", ["from_id", "created_at"], :name => "index_messages_on_from_id_and_created_at"

  create_table "news_posts", :force => true do |t|
    t.string   "title",                         :null => false
    t.text     "contents",                      :null => false
    t.integer  "user_id",                       :null => false
    t.boolean  "published",  :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title",                         :null => false
    t.text     "contents",                      :null => false
    t.string   "url",        :default => "",    :null => false
    t.integer  "parent_id"
    t.integer  "user_id",                       :null => false
    t.boolean  "published",  :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"
  add_index "pages", ["published", "title"], :name => "index_pages_on_published_and_title"
  add_index "pages", ["url"], :name => "index_pages_on_url"

  create_table "received_messages", :force => true do |t|
    t.integer  "message_id",                    :null => false
    t.integer  "to_id",                         :null => false
    t.boolean  "read",       :default => false, :null => false
    t.boolean  "flagged",    :default => false, :null => false
    t.boolean  "deleted",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "received_messages", ["flagged", "created_at"], :name => "index_received_messages_flagged"
  add_index "received_messages", ["to_id", "deleted", "created_at"], :name => "index_received_messages_to_deleted"
  add_index "received_messages", ["to_id", "read", "created_at"], :name => "index_received_messages_to_read"

  create_table "series", :force => true do |t|
    t.integer  "user_id",                             :null => false
    t.string   "title",                               :null => false
    t.text     "description"
    t.text     "story_list_cache"
    t.boolean  "deleted",          :default => false, :null => false
    t.text     "deleted_reason",   :default => "",    :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "stories", :force => true do |t|
    t.string   "title",                              :null => false
    t.integer  "user_id",                            :null => false
    t.text     "contents",                           :null => false
    t.text     "deleted_reason",  :default => "",    :null => false
    t.boolean  "deleted",         :default => false, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "series_id"
    t.integer  "series_position", :default => 1
  end

  add_index "stories", ["deleted", "id"], :name => "index_stories_on_deleted_and_id"
  add_index "stories", ["series_id"], :name => "index_stories_on_series_id"
  add_index "stories", ["user_id"], :name => "index_stories_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",                                                     :null => false
    t.string   "gender"
    t.string   "timezone"
    t.text     "biography",                             :default => "",    :null => false
    t.text     "facebook_data"
    t.boolean  "admin",                                 :default => false, :null => false
    t.boolean  "never_set_password",                    :default => false, :null => false
    t.boolean  "prevent_login",                         :default => false, :null => false
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "facebook_token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "ip_address"
    t.string   "user_agent"
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "watches", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.string   "watchable_type",                    :null => false
    t.integer  "watchable_id",                      :null => false
    t.boolean  "public",         :default => true,  :null => false
    t.boolean  "stories",        :default => false, :null => false
    t.boolean  "poems",          :default => false, :null => false
    t.boolean  "journals",       :default => false, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "watches", ["user_id", "watchable_type", "watchable_id"], :name => "idx_watch_user_watchable"
  add_index "watches", ["watchable_type", "watchable_id"], :name => "idx_watch_watchable"

end
