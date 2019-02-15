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

ActiveRecord::Schema.define(version: 20190213101043) do

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level"
    t.bigint "trank_id"
    t.index ["trank_id"], name: "index_answers_on_trank_id"
  end

  create_table "configs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.text "password_encrypted"
    t.boolean "is_outgoing_deleted"
    t.boolean "is_outgoing_table_showed"
    t.boolean "is_google_integrated"
    t.boolean "is_attempt_supported"
    t.boolean "is_answer_supported"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.string "default_trank_context"
    t.boolean "is_trank_context_showed"
    t.boolean "is_menu_service_showed"
    t.boolean "is_vote_supported"
    t.integer "prefix_contry", default: 7
  end

  create_table "configurations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.text "password_encrypted"
    t.boolean "is_outgoing_deleted"
    t.boolean "is_outgoing_table_showed"
    t.boolean "is_google_integrated"
    t.boolean "is_attempt_supported"
    t.boolean "is_answer_supported"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "phone"
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "peer"
    t.index ["task_id", "created_at"], name: "index_contacts_on_task_id_and_created_at"
    t.index ["task_id"], name: "index_contacts_on_task_id"
  end

  create_table "dialplans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "title"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "phone"
    t.string "dialer_status"
    t.integer "dialer_attempt"
    t.boolean "is_offer_accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "update_at"
  end

  create_table "machines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "telephone"
    t.string "amdstatus"
    t.string "amdcause"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outgoings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.datetime "date_created"
    t.integer "attempt_current"
    t.bigint "trank_id"
    t.index ["trank_id"], name: "index_outgoings_on_trank_id"
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "callcount"
    t.text "sipnames"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "currentcount"
    t.string "outgoing"
    t.integer "sleep"
    t.boolean "is_enabled"
    t.integer "waittime"
    t.string "trank"
    t.integer "hour_bgn"
    t.integer "hour_end"
    t.integer "attempt_max_count", default: 0
    t.integer "attempt_interval", default: 60
    t.integer "google_sheet_count"
    t.integer "google_sheet_current", default: 0
    t.text "google_title"
    t.string "google_private_key_file_name"
    t.string "google_private_key_content_type"
    t.integer "google_private_key_file_size"
    t.datetime "google_private_key_updated_at"
    t.text "title"
    t.string "leadback_phone"
  end

  create_table "spools", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "outgoing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "trank_id"
    t.index ["outgoing_id"], name: "index_spools_on_outgoing_id"
    t.index ["trank_id"], name: "index_spools_on_trank_id"
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "tranks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name"
    t.string "callerid"
    t.integer "waittime"
    t.integer "callcount"
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefix", default: ""
    t.string "context"
    t.bigint "vote_welcome_id"
    t.bigint "vote_finish_id"
    t.bigint "vote_push_two_id"
    t.bigint "dialplan_id"
    t.integer "callmax"
    t.integer "sleeptime"
    t.index ["dialplan_id"], name: "index_tranks_on_dialplan_id"
    t.index ["vote_finish_id"], name: "index_tranks_on_vote_finish_id"
    t.index ["vote_push_two_id"], name: "index_tranks_on_vote_push_two_id"
    t.index ["vote_welcome_id"], name: "index_tranks_on_vote_welcome_id"
  end

  create_table "votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "title"
    t.string "record_file_name"
    t.string "record_content_type"
    t.integer "record_file_size"
    t.datetime "record_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "tranks"
  add_foreign_key "contacts", "tasks"
  add_foreign_key "outgoings", "tranks"
  add_foreign_key "spools", "outgoings"
  add_foreign_key "spools", "tranks"
  add_foreign_key "tranks", "dialplans"
  add_foreign_key "tranks", "votes", column: "vote_finish_id"
  add_foreign_key "tranks", "votes", column: "vote_push_two_id"
  add_foreign_key "tranks", "votes", column: "vote_welcome_id"
end
