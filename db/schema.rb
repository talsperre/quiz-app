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

ActiveRecord::Schema.define(version: 20170919162926) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "lifelines", force: :cascade do |t|
    t.integer "quiz_id"
    t.integer "user_id"
    t.string "ltype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_lifelines_on_quiz_id"
    t.index ["user_id"], name: "index_lifelines_on_user_id"
  end

  create_table "q_images", force: :cascade do |t|
    t.integer "question_id"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_q_images_on_question_id"
  end

  create_table "q_states", force: :cascade do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quiz_id"
    t.index ["question_id"], name: "index_q_states_on_question_id"
    t.index ["quiz_id"], name: "index_q_states_on_quiz_id"
    t.index ["user_id"], name: "index_q_states_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.string "qtype"
    t.text "option_one"
    t.text "option_two"
    t.text "option_three"
    t.text "option_four"
    t.text "answer"
    t.integer "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "name"
    t.integer "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_quizzes_on_name", unique: true
    t.index ["subcategory_id"], name: "index_quizzes_on_subcategory_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "is_quiz"
    t.integer "quiz_id"
    t.boolean "is_subcategory"
    t.integer "subcategory_id"
    t.boolean "is_category"
    t.integer "category_id"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_scores_on_category_id"
    t.index ["quiz_id"], name: "index_scores_on_quiz_id"
    t.index ["subcategory_id"], name: "index_scores_on_subcategory_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.integer "user_id"
    t.integer "quiz_id"
    t.integer "count"
    t.integer "score"
    t.boolean "complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_states_on_quiz_id"
    t.index ["user_id"], name: "index_states_on_user_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
    t.index ["name"], name: "index_subcategories_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "gender"
    t.boolean "admin", default: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["uid"], name: "index_users_on_uid"
  end

end
