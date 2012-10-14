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

ActiveRecord::Schema.define(:version => 20121014031604) do

  create_table "kindeditor_assets", :force => true do |t|
    t.string   "asset"
    t.integer  "file_size"
    t.string   "file_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "grade_or_class",        :default => ""
    t.string   "subject",               :default => ""
    t.string   "school",                :default => ""
    t.string   "research_time",         :default => ""
    t.text     "bk_purpose_importance", :default => ""
    t.text     "content_question",      :default => ""
    t.text     "cond_outcome",          :default => ""
    t.text     "feature_creation",      :default => ""
    t.text     "process",               :default => ""
    t.text     "opinion1",              :default => ""
    t.text     "opinion2",              :default => ""
    t.text     "mid_research"
    t.text     "final_result"
    t.text     "renewal"
    t.text     "attach_data"
    t.text     "evaluate_result"
    t.integer  "creator_id"
    t.integer  "term_id"
  end

  create_table "terms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                    :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "popedom",                      :default => 0
    t.integer  "age"
    t.string   "level"
    t.string   "major"
    t.string   "subject"
    t.string   "phone"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

  create_table "users_posts", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "post_id",                          :null => false
    t.integer  "operate_post_flag", :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

end
