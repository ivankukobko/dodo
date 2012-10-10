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

ActiveRecord::Schema.define(:version => 20121010131129) do

  create_table "administrators", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "administrators", ["user_id"], :name => "index_administrators_on_user_id"

  create_table "assignees", :force => true do |t|
    t.integer  "user_id"
    t.integer  "todo_item_id"
    t.integer  "assigned_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "assignees", ["assigned_by"], :name => "index_assignees_on_assigned_by"
  add_index "assignees", ["todo_item_id"], :name => "index_assignees_on_todo_item_id"
  add_index "assignees", ["user_id"], :name => "index_assignees_on_user_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "collaborators", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "role_id",    :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "collaborators", ["project_id"], :name => "index_collaborators_on_project_id"
  add_index "collaborators", ["user_id"], :name => "index_collaborators_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "todo_item_id"
    t.integer  "parent_id"
    t.text     "body"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"
  add_index "comments", ["todo_item_id"], :name => "index_comments_on_todo_item_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "info_pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.integer  "parent_id"
    t.boolean  "promote_to_home", :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "info_pages", ["parent_id"], :name => "index_info_pages_on_parent_id"

  create_table "invitations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "invited_by",  :null => false
    t.datetime "accepted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "invitations", ["invited_by"], :name => "index_invitations_on_invited_by"
  add_index "invitations", ["project_id"], :name => "index_invitations_on_project_id"
  add_index "invitations", ["user_id"], :name => "index_invitations_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "todo_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "todo_list_id"
    t.boolean  "is_complete",  :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "position",     :default => 0,     :null => false
    t.datetime "due_date"
  end

  create_table "todo_lists", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "project_id"
  end

  add_index "todo_lists", ["project_id"], :name => "index_todo_lists_on_project_id"
  add_index "todo_lists", ["user_id"], :name => "index_todo_lists_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_salt"
    t.string   "password_hash"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "worklogs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "todo_item_id"
    t.date     "log_date"
    t.integer  "duration"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "is_billed",    :default => false
  end

  add_index "worklogs", ["todo_item_id"], :name => "index_worklogs_on_todo_item_id"
  add_index "worklogs", ["user_id"], :name => "index_worklogs_on_user_id"

end
