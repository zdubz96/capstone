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

ActiveRecord::Schema[7.1].define(version: 2025_05_25_175524) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.string "correct_option"
    t.string "explanation"
    t.integer "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "options", default: {}, null: false
    t.integer "difficulty"
  end

  create_table "quiz_session_questions", force: :cascade do |t|
    t.bigint "quiz_session_id", null: false
    t.bigint "question_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "answer"
    t.boolean "correct"
    t.index ["question_id"], name: "index_quiz_session_questions_on_question_id"
    t.index ["quiz_session_id"], name: "index_quiz_session_questions_on_quiz_session_id"
  end

  create_table "quiz_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_quiz_sessions_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_topic_competencies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "topic_id", null: false
    t.float "accuracy"
    t.float "average_difficulty"
    t.integer "attempts"
    t.integer "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "easy_attempts", default: 0, null: false
    t.integer "easy_correct", default: 0, null: false
    t.integer "medium_attempts", default: 0, null: false
    t.integer "medium_correct", default: 0, null: false
    t.integer "hard_attempts", default: 0, null: false
    t.integer "hard_correct", default: 0, null: false
    t.index ["topic_id"], name: "index_user_topic_competencies_on_topic_id"
    t.index ["user_id"], name: "index_user_topic_competencies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "quiz_session_questions", "questions"
  add_foreign_key "quiz_session_questions", "quiz_sessions"
  add_foreign_key "quiz_sessions", "users"
  add_foreign_key "user_topic_competencies", "topics"
  add_foreign_key "user_topic_competencies", "users"
end
