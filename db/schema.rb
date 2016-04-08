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

ActiveRecord::Schema.define(version: 20160407234739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artifacts", force: :cascade do |t|
    t.string   "name",                            null: false
    t.text     "description",     default: ""
    t.string   "alternate_names", default: [],    null: false, array: true
    t.string   "artist"
    t.string   "dimensions"
    t.string   "date_created"
    t.boolean  "group",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "artifacts", ["alternate_names"], name: "index_artifacts_on_alternate_names", using: :btree
  add_index "artifacts", ["group"], name: "index_artifacts_on_group", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "name"
    t.string   "description"
    t.string   "company"
    t.string   "location"
    t.string   "role",                            default: "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "failed_logins_count",             default: 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", using: :btree

end