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

ActiveRecord::Schema.define(:version => 20111229233948) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_type", "commentable_id", "deleted"], :name => "index_comments_on_commentable"
  add_index "comments", ["parent_id", "position"], :name => "index_comments_on_parent_id_and_position"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "literatures", :force => true do |t|
    t.string   "title",                             :null => false
    t.integer  "user_id",                           :null => false
    t.text     "contents",                          :null => false
    t.text     "deleted_reason", :default => "",    :null => false
    t.boolean  "deleted",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "literatures", ["deleted", "id"], :name => "index_literatures_on_deleted_and_id"
  add_index "literatures", ["user_id"], :name => "index_literatures_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",                                                     :null => false
    t.string   "gender"
    t.string   "timezone"
    t.boolean  "admin",                                 :default => false, :null => false
    t.text     "biography",                             :default => "",    :null => false
    t.text     "facebook_data"
    t.boolean  "never_set_password",                    :default => false, :null => false
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
