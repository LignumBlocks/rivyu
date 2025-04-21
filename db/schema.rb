# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_12_17_111928) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.string "link"
    t.text "content"
    t.boolean "success"
    t.json "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "are_hacks"
    t.text "justification"
    t.text "content_summary"
    t.index ["source_id"], name: "index_articles_on_source_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "classification_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "for_super_hacks", default: false
    t.index ["classification_id", "name"], name: "index_categories_on_classification_id_and_name"
    t.index ["classification_id"], name: "index_categories_on_classification_id"
  end

  create_table "classifications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "combined_hacks", force: :cascade do |t|
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hack_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "hack_id", null: false
    t.text "justification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_hack_categories_on_category_id"
    t.index ["hack_id", "category_id"], name: "index_hack_categories_on_hack_id_and_category_id"
    t.index ["hack_id"], name: "index_hack_categories_on_hack_id"
  end

  create_table "hack_validation_superhacks", force: :cascade do |t|
    t.integer "id_hack_compared_first"
    t.integer "id_hack_compared_second"
    t.boolean "has_superhack"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hacks", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.text "summary"
    t.text "justification"
    t.text "steps_summary"
    t.text "resources_needed"
    t.text "expected_benefits"
    t.text "detailed_steps"
    t.text "additional_tools_resources"
    t.text "case_study"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "init_title"
    t.string "free_title"
    t.string "premium_title"
    t.text "description"
    t.string "main_goal"
    t.boolean "is_advice", default: false
    t.string "advice_justification", default: ""
    t.boolean "synchronized", default: false
    t.boolean "completed", default: false
    t.boolean "sent_to_python", default: false
    t.index ["article_id"], name: "index_hacks_on_article_id"
    t.index ["description"], name: "index_hacks_on_description"
    t.index ["is_advice"], name: "index_hacks_on_is_advice"
    t.index ["main_goal"], name: "index_hacks_on_main_goal"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "superhack_categories", force: :cascade do |t|
    t.bigint "superhack_id", null: false
    t.bigint "category_id", null: false
    t.text "justification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_superhack_categories_on_category_id"
    t.index ["superhack_id"], name: "index_superhack_categories_on_superhack_id"
  end

  create_table "superhack_sources", force: :cascade do |t|
    t.bigint "superhack_id", null: false
    t.bigint "hack_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hack_id"], name: "index_superhack_sources_on_hack_id"
    t.index ["superhack_id"], name: "index_superhack_sources_on_superhack_id"
  end

  create_table "superhacks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "implementation_steps"
    t.text "expected_results"
    t.text "risks_and_mitigation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "sources"
  add_foreign_key "categories", "classifications"
  add_foreign_key "hack_categories", "categories"
  add_foreign_key "hack_categories", "hacks"
  add_foreign_key "hacks", "articles"
  add_foreign_key "superhack_categories", "categories"
  add_foreign_key "superhack_categories", "superhacks"
  add_foreign_key "superhack_sources", "hacks"
  add_foreign_key "superhack_sources", "superhacks"
end
