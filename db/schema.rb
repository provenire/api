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

ActiveRecord::Schema.define(version: 20160408031635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "affiliations", force: :cascade do |t|
    t.uuid     "uuid",        default: "uuid_generate_v4()"
    t.string   "slug",                                       null: false
    t.string   "name",                                       null: false
    t.text     "description", default: ""
    t.integer  "person_id"
    t.integer  "place_id"
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "current",     default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "affiliations", ["person_id"], name: "index_affiliations_on_person_id", using: :btree
  add_index "affiliations", ["place_id"], name: "index_affiliations_on_place_id", using: :btree
  add_index "affiliations", ["slug"], name: "index_affiliations_on_slug", unique: true, using: :btree
  add_index "affiliations", ["uuid"], name: "index_affiliations_on_uuid", unique: true, using: :btree

  create_table "annotations", force: :cascade do |t|
    t.uuid     "uuid",        default: "uuid_generate_v4()"
    t.integer  "page_id"
    t.integer  "tagged_id"
    t.string   "tagged_type"
    t.string   "name",        default: "",                   null: false
    t.text     "description", default: ""
    t.json     "location"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "annotations", ["page_id"], name: "index_annotations_on_page_id", using: :btree
  add_index "annotations", ["tagged_type", "tagged_id"], name: "index_annotations_on_tagged_type_and_tagged_id", using: :btree
  add_index "annotations", ["uuid"], name: "index_annotations_on_uuid", unique: true, using: :btree

  create_table "artifacts", force: :cascade do |t|
    t.uuid     "uuid",            default: "uuid_generate_v4()"
    t.string   "slug",                                           null: false
    t.string   "name",                                           null: false
    t.text     "description",     default: ""
    t.string   "alternate_names", default: [],                   null: false, array: true
    t.string   "artist"
    t.string   "dimensions"
    t.string   "date_created"
    t.boolean  "group",           default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "artifacts", ["alternate_names"], name: "index_artifacts_on_alternate_names", using: :btree
  add_index "artifacts", ["group"], name: "index_artifacts_on_group", using: :btree
  add_index "artifacts", ["slug"], name: "index_artifacts_on_slug", unique: true, using: :btree
  add_index "artifacts", ["uuid"], name: "index_artifacts_on_uuid", unique: true, using: :btree

  create_table "artifacts_events", id: false, force: :cascade do |t|
    t.integer "artifact_id", null: false
    t.integer "event_id",    null: false
  end

  add_index "artifacts_events", ["artifact_id", "event_id"], name: "index_artifacts_events_on_artifact_id_and_event_id", using: :btree
  add_index "artifacts_events", ["event_id", "artifact_id"], name: "index_artifacts_events_on_event_id_and_artifact_id", using: :btree

  create_table "citations", force: :cascade do |t|
    t.integer  "source_id"
    t.integer  "entry_id"
    t.string   "entry_type"
    t.integer  "number"
    t.string   "content",    default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "citations", ["entry_type", "entry_id"], name: "index_citations_on_entry_type_and_entry_id", using: :btree
  add_index "citations", ["source_id"], name: "index_citations_on_source_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.uuid     "uuid",           default: "uuid_generate_v4()"
    t.string   "slug",                                          null: false
    t.string   "name",                                          null: false
    t.text     "description",    default: ""
    t.date     "date"
    t.string   "status"
    t.boolean  "failed",         default: false,                null: false
    t.integer  "verb_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "price_cents",    default: 0,                    null: false
    t.string   "price_currency", default: "USD",                null: false
  end

  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree
  add_index "events", ["status"], name: "index_events_on_status", using: :btree
  add_index "events", ["uuid"], name: "index_events_on_uuid", unique: true, using: :btree
  add_index "events", ["verb_id"], name: "index_events_on_verb_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "interactions", force: :cascade do |t|
    t.integer  "actor_id"
    t.string   "actor_type"
    t.integer  "event_id"
    t.boolean  "recipient",     default: true,  null: false
    t.boolean  "unknown_actor", default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "interactions", ["actor_type", "actor_id"], name: "index_interactions_on_actor_type_and_actor_id", using: :btree
  add_index "interactions", ["event_id"], name: "index_interactions_on_event_id", using: :btree
  add_index "interactions", ["recipient"], name: "index_interactions_on_recipient", using: :btree
  add_index "interactions", ["unknown_actor"], name: "index_interactions_on_unknown_actor", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "source_id"
    t.integer  "number"
    t.text     "text"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pages", ["number"], name: "index_pages_on_number", using: :btree
  add_index "pages", ["source_id", "number"], name: "index_pages_on_source_id_and_number", unique: true, using: :btree
  add_index "pages", ["source_id"], name: "index_pages_on_source_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.uuid     "uuid",          default: "uuid_generate_v4()"
    t.string   "slug",                                         null: false
    t.string   "name",                                         null: false
    t.text     "description",   default: ""
    t.string   "gender",        default: "unknown"
    t.date     "date_of_birth"
    t.date     "date_of_death"
    t.string   "nationality",   default: "unknown"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "people", ["slug"], name: "index_people_on_slug", unique: true, using: :btree
  add_index "people", ["uuid"], name: "index_people_on_uuid", unique: true, using: :btree

  create_table "places", force: :cascade do |t|
    t.uuid     "uuid",        default: "uuid_generate_v4()"
    t.string   "slug",                                       null: false
    t.string   "name",                                       null: false
    t.text     "description", default: ""
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "places", ["slug"], name: "index_places_on_slug", unique: true, using: :btree
  add_index "places", ["uuid"], name: "index_places_on_uuid", unique: true, using: :btree

  create_table "sources", force: :cascade do |t|
    t.uuid     "uuid",         default: "uuid_generate_v4()"
    t.string   "slug",                                        null: false
    t.string   "kind",         default: "document",           null: false
    t.string   "name",                                        null: false
    t.text     "description",  default: ""
    t.string   "authors",      default: ""
    t.date     "date_created"
    t.string   "attribution",  default: ""
    t.string   "identifier"
    t.string   "thumbnail"
    t.string   "document"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "sources", ["attribution"], name: "index_sources_on_attribution", using: :btree
  add_index "sources", ["authors"], name: "index_sources_on_authors", using: :btree
  add_index "sources", ["identifier"], name: "index_sources_on_identifier", using: :btree
  add_index "sources", ["kind"], name: "index_sources_on_kind", using: :btree
  add_index "sources", ["slug"], name: "index_sources_on_slug", unique: true, using: :btree
  add_index "sources", ["uuid"], name: "index_sources_on_uuid", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                          null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "slug",                                                           null: false
    t.uuid     "uuid",                            default: "uuid_generate_v4()"
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
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", using: :btree
  add_index "users", ["uuid"], name: "index_users_on_uuid", unique: true, using: :btree

  create_table "verbs", force: :cascade do |t|
    t.string   "keyword",                                                     null: false
    t.string   "action",                                                      null: false
    t.string   "noun",                                                        null: false
    t.string   "components",      default: ["date", "status", "description"], null: false, array: true
    t.string   "subject_types",   default: ["people", "places"],              null: false, array: true
    t.string   "recipient_types", default: ["people", "places"],              null: false, array: true
    t.integer  "subject_limit"
    t.integer  "recipient_limit"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  add_index "verbs", ["action"], name: "index_verbs_on_action", unique: true, using: :btree
  add_index "verbs", ["keyword"], name: "index_verbs_on_keyword", unique: true, using: :btree
  add_index "verbs", ["noun"], name: "index_verbs_on_noun", unique: true, using: :btree

end
