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

ActiveRecord::Schema.define(version: 2022_11_20_222202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "affiliates", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "client_id"
    t.string "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_affiliates_on_client_id"
    t.index ["organization_id"], name: "index_affiliates_on_organization_id"
  end

  create_table "ask_for_testimonies", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_ask_for_testimonies_on_organization_id"
  end

  create_table "awards", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.text "current_client"
    t.text "new_client"
    t.text "rule"
    t.string "business_cell_phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_awards_on_organization_id"
  end

  create_table "client_accessibilities", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_client_accessibilities_on_client_id"
    t.index ["group_id"], name: "index_client_accessibilities_on_group_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone_number"
    t.string "full_name"
    t.bigint "organization_id", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email", "organization_id"], name: "index_clients_on_email_and_organization_id", unique: true
    t.index ["organization_id"], name: "index_clients_on_organization_id"
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
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

  create_table "groups", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "creator_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["creator_id"], name: "index_groups_on_creator_id"
    t.index ["organization_id"], name: "index_groups_on_organization_id"
    t.index ["slug"], name: "index_groups_on_slug", unique: true
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "group_id"
    t.string "key"
    t.string "role_type"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_invites_on_group_id"
    t.index ["organization_id"], name: "index_invites_on_organization_id"
  end

  create_table "leads", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "origin_type", null: false
    t.bigint "origin_id", null: false
    t.string "full_name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_leads_on_organization_id"
    t.index ["origin_type", "origin_id"], name: "index_leads_on_origin"
  end

  create_table "mentions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_mentions_on_task_id"
    t.index ["user_id"], name: "index_mentions_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id"
    t.string "description"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "visualized", default: false
    t.index ["group_id"], name: "index_notifications_on_group_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "title"
    t.string "state"
    t.string "email"
    t.string "phone_number"
    t.string "primary_color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "pinned_links", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.string "link"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_pinned_links_on_group_id"
  end

  create_table "print_awards", force: :cascade do |t|
    t.string "current_client"
    t.string "new_client"
    t.string "rule"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rating_answers", force: :cascade do |t|
    t.bigint "rating_question_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rating_question_id"], name: "index_rating_answers_on_rating_question_id"
    t.index ["task_id"], name: "index_rating_answers_on_task_id"
  end

  create_table "rating_questions", force: :cascade do |t|
    t.integer "value"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.string "description"
    t.integer "stars"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_ratings_on_task_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "affiliate_id", null: false
    t.bigint "print_award_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["affiliate_id"], name: "index_rewards_on_affiliate_id"
    t.index ["print_award_id"], name: "index_rewards_on_print_award_id"
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

  create_table "sub_tasks", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "initial_date"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_sub_tasks_on_creator_id"
    t.index ["task_id"], name: "index_sub_tasks_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "creator_id"
    t.bigint "group_id"
    t.string "title"
    t.string "activity_link"
    t.datetime "initial_date"
    t.datetime "final_date"
    t.integer "interval_to_update"
    t.boolean "notified_by_email"
    t.boolean "closed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["creator_id"], name: "index_tasks_on_creator_id"
    t.index ["group_id"], name: "index_tasks_on_group_id"
    t.index ["slug"], name: "index_tasks_on_slug", unique: true
  end

  create_table "testimonies", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "client_id"
    t.bigint "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_testimonies_on_client_id"
    t.index ["group_id"], name: "index_testimonies_on_group_id"
    t.index ["organization_id"], name: "index_testimonies_on_organization_id"
  end

  create_table "user_accessibilities", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.string "allow"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_user_accessibilities_on_group_id"
    t.index ["user_id"], name: "index_user_accessibilities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone_number"
    t.string "email_security_key"
    t.boolean "confirm_email", default: false, null: false
    t.boolean "blocked", default: false
    t.datetime "expire_invitation"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "affiliates", "clients"
  add_foreign_key "affiliates", "organizations"
  add_foreign_key "ask_for_testimonies", "organizations"
  add_foreign_key "awards", "organizations"
  add_foreign_key "client_accessibilities", "clients"
  add_foreign_key "client_accessibilities", "groups"
  add_foreign_key "clients", "organizations"
  add_foreign_key "groups", "organizations"
  add_foreign_key "groups", "users", column: "creator_id"
  add_foreign_key "invites", "groups"
  add_foreign_key "invites", "organizations"
  add_foreign_key "leads", "organizations"
  add_foreign_key "mentions", "tasks"
  add_foreign_key "mentions", "users"
  add_foreign_key "notifications", "groups"
  add_foreign_key "notifications", "users"
  add_foreign_key "pinned_links", "groups"
  add_foreign_key "rating_answers", "rating_questions"
  add_foreign_key "rating_answers", "tasks"
  add_foreign_key "ratings", "tasks"
  add_foreign_key "rewards", "affiliates"
  add_foreign_key "rewards", "print_awards"
  add_foreign_key "roles", "organizations"
  add_foreign_key "roles", "users"
  add_foreign_key "sub_tasks", "tasks"
  add_foreign_key "sub_tasks", "users", column: "creator_id"
  add_foreign_key "tasks", "groups"
  add_foreign_key "tasks", "users", column: "creator_id"
  add_foreign_key "testimonies", "clients"
  add_foreign_key "testimonies", "groups"
  add_foreign_key "testimonies", "organizations"
  add_foreign_key "user_accessibilities", "groups"
  add_foreign_key "user_accessibilities", "users"
end
