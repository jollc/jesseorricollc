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

ActiveRecord::Schema.define(version: 20171208162942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "alerts", id: :serial, force: :cascade do |t|
    t.string "content"
    t.date "start_date"
    t.date "end_date"
    t.string "link"
    t.text "notes"
    t.boolean "archive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "author"
    t.text "content"
    t.string "link_text"
    t.string "link_url"
    t.boolean "archived"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_uid"
  end

  create_table "permissions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "page_id"
    t.datetime "created_at"
    t.index ["page_id"], name: "index_permissions_on_page_id"
    t.index ["user_id"], name: "index_permissions_on_user_id"
  end

  create_table "simplec_document_sets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.boolean "required", default: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_simplec_document_sets_on_name"
    t.index ["slug"], name: "index_simplec_document_sets_on_slug"
  end

  create_table "simplec_document_sets_subdomains", force: :cascade do |t|
    t.uuid "document_set_id"
    t.uuid "subdomain_id"
    t.index ["document_set_id", "subdomain_id"], name: "index_simplec_document_sets_subdomains_unique", unique: true
  end

  create_table "simplec_documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "document_set_id"
    t.string "slug"
    t.string "name"
    t.boolean "required", default: false
    t.text "description"
    t.string "file_uid"
    t.string "file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_set_id"], name: "index_simplec_documents_on_document_set_id"
    t.index ["name"], name: "index_simplec_documents_on_name"
    t.index ["slug"], name: "index_simplec_documents_on_slug"
  end

  create_table "simplec_documents_subdomains", force: :cascade do |t|
    t.uuid "document_id"
    t.uuid "subdomain_id"
    t.index ["document_id", "subdomain_id"], name: "index_simplec_documents_subdomains_unique", unique: true
  end

  create_table "simplec_embedded_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "embeddable_type"
    t.uuid "embeddable_id"
    t.string "asset_uid"
    t.string "asset_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["embeddable_type", "embeddable_id"], name: "simplec_embedded_images_type_id_index"
  end

  create_table "simplec_pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.uuid "subdomain_id"
    t.uuid "parent_id"
    t.string "path"
    t.string "slug"
    t.string "title"
    t.string "meta_description"
    t.jsonb "fields", default: {}
    t.string "layout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.tsvector "tsv"
    t.jsonb "query", default: {}
    t.jsonb "text", default: {"a"=>nil, "b"=>nil, "c"=>nil, "d"=>nil}
    t.index "query jsonb_path_ops", name: "simplec_pages_query", using: :gin
    t.index ["parent_id"], name: "index_simplec_pages_on_parent_id"
    t.index ["path"], name: "index_simplec_pages_on_path"
    t.index ["subdomain_id", "path"], name: "index_simplec_pages_on_subdomain_id_and_path", unique: true
    t.index ["subdomain_id"], name: "index_simplec_pages_on_subdomain_id"
    t.index ["tsv"], name: "index_simplec_pages_on_tsv", using: :gin
    t.index ["type"], name: "index_simplec_pages_on_type"
  end

  create_table "simplec_subdomains", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "default_layout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_simplec_subdomains_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sysadmin", default: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["sysadmin"], name: "index_users_on_sysadmin"
  end

end
