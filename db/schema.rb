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

ActiveRecord::Schema.define(version: 2022_10_22_135925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessibilities", force: :cascade do |t|
    t.string "foldable_type"
    t.bigint "foldable_id"
    t.bigint "user_id", null: false
    t.string "allows"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["foldable_type", "foldable_id"], name: "index_accessibilities_on_foldable"
    t.index ["user_id"], name: "index_accessibilities_on_user_id"
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "folders", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "creator_id"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "foldable_id"
    t.string "slug"
    t.index ["creator_id"], name: "index_folders_on_creator_id"
    t.index ["foldable_id"], name: "index_folders_on_foldable_id"
    t.index ["project_id"], name: "index_folders_on_project_id"
    t.index ["slug"], name: "index_folders_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "mentions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "viewer_type"
    t.bigint "viewer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_mentions_on_user_id"
    t.index ["viewer_type", "viewer_id"], name: "index_mentions_on_viewer"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "creator_id"
    t.boolean "send_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_messages_on_creator_id"
    t.index ["task_id"], name: "index_messages_on_task_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "description"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "title"
    t.string "state"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "previews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "viewer_type"
    t.bigint "viewer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_previews_on_user_id"
    t.index ["viewer_type", "viewer_id"], name: "index_previews_on_viewer"
  end

  create_table "project_notifications", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.boolean "receive_email_when_tagged"
    t.boolean "receive_email_when_client_responds"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_notifications_on_project_id"
    t.index ["user_id"], name: "index_project_notifications_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["organization_id"], name: "index_projects_on_organization_id"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.string "role_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_roles_on_organization_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "taskable_type"
    t.bigint "taskable_id"
    t.datetime "execution_date"
    t.integer "days_to_make_mandatory"
    t.boolean "repeat", default: false, null: false
    t.integer "interval_repeat", null: false
    t.integer "day_of_repeat", null: false
    t.integer "minute_of_repeat", null: false
    t.integer "hour_of_repeat", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["taskable_type", "taskable_id"], name: "index_schedules_on_taskable"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "folder_id"
    t.bigint "creator_id"
    t.string "title"
    t.string "link"
    t.string "type_task"
    t.boolean "send_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["creator_id"], name: "index_tasks_on_creator_id"
    t.index ["folder_id"], name: "index_tasks_on_folder_id"
    t.index ["slug"], name: "index_tasks_on_slug", unique: true
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "invitation", default: false
    t.boolean "blocked", default: false
    t.string "email_security_key"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accessibilities", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "folders", "folders", column: "foldable_id"
  add_foreign_key "folders", "projects"
  add_foreign_key "folders", "users", column: "creator_id"
  add_foreign_key "mentions", "users"
  add_foreign_key "messages", "tasks"
  add_foreign_key "messages", "users", column: "creator_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "previews", "users"
  add_foreign_key "project_notifications", "projects"
  add_foreign_key "project_notifications", "users"
  add_foreign_key "projects", "organizations"
  add_foreign_key "roles", "organizations"
  add_foreign_key "roles", "users"
  add_foreign_key "tasks", "folders"
  add_foreign_key "tasks", "users"
  add_foreign_key "tasks", "users", column: "creator_id"
end
