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

ActiveRecord::Schema.define(version: 2022_11_25_134422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_metrics", force: :cascade do |t|
    t.string "usable_type"
    t.bigint "usable_id"
    t.bigint "organization_id", null: false
    t.string "situation"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_access_metrics_on_organization_id"
    t.index ["usable_type", "usable_id"], name: "index_access_metrics_on_usable"
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

  create_table "affiliates", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "full_name"
    t.string "email"
    t.string "phone_number"
    t.string "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["organization_id"], name: "index_affiliates_on_organization_id"
    t.index ["slug"], name: "index_affiliates_on_slug", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.string "phone_number"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email", "organization_id"], name: "index_clients_on_email_and_organization_id", unique: true
    t.index ["organization_id"], name: "index_clients_on_organization_id"
    t.index ["phone_number", "organization_id"], name: "index_clients_on_phone_number_and_organization_id", unique: true
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

  create_table "invites", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "role_type"
    t.string "key"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_invites_on_organization_id"
  end

  create_table "leads", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "full_name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_leads_on_organization_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "usable_type"
    t.bigint "usable_id"
    t.string "description"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "visualized", default: false
    t.index ["usable_type", "usable_id"], name: "index_notifications_on_usable"
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

  create_table "affiliate_campaigns", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "title"
    t.string "subtitle"
    t.string "description"
    t.string "title_form"
    t.string "subtitle_form"
    t.string "rule_title"
    t.string "rule_description"
    t.string "background_color"
    t.string "primary_color"
    t.string "secondary_color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_affiliate_campaigns_on_organization_id"
  end

  create_table "reward_affiliates", force: :cascade do |t|
    t.bigint "reward_id", null: false
    t.bigint "affiliate_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["affiliate_id"], name: "index_reward_affiliates_on_affiliate_id"
    t.index ["reward_id"], name: "index_reward_affiliates_on_reward_id"
  end

  create_table "reward_leads", force: :cascade do |t|
    t.bigint "reward_id", null: false
    t.bigint "lead_id", null: false
    t.jsonb "reward_story"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lead_id"], name: "index_reward_leads_on_lead_id"
    t.index ["reward_id"], name: "index_reward_leads_on_reward_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "type_of_reward"
    t.string "social_network"
    t.string "username"
    t.string "to_affiliate"
    t.string "to_lead"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_rewards_on_organization_id"
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

  add_foreign_key "access_metrics", "organizations"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "affiliates", "organizations"
  add_foreign_key "clients", "organizations"
  add_foreign_key "invites", "organizations"
  add_foreign_key "leads", "organizations"
  add_foreign_key "affiliate_campaigns", "organizations"
  add_foreign_key "reward_affiliates", "affiliates"
  add_foreign_key "reward_affiliates", "rewards"
  add_foreign_key "reward_leads", "leads"
  add_foreign_key "reward_leads", "rewards"
  add_foreign_key "rewards", "organizations"
  add_foreign_key "roles", "organizations"
  add_foreign_key "roles", "users"
end
