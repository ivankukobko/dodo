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

ActiveRecord::Schema.define(:version => 20111219180020) do

  create_table "collaborators", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "role_id",     :default => 0
    t.integer  "invited_by"
    t.integer  "accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collaborators", ["invited_by"], :name => "index_collaborators_on_invited_by"
  add_index "collaborators", ["project_id"], :name => "index_collaborators_on_project_id"
  add_index "collaborators", ["user_id"], :name => "index_collaborators_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todo_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "todo_list_id"
    t.boolean  "is_complete",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",     :default => 0,     :null => false
  end

  create_table "todo_lists", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  add_index "todo_lists", ["project_id"], :name => "index_todo_lists_on_project_id"
  add_index "todo_lists", ["user_id"], :name => "index_todo_lists_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_salt"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
