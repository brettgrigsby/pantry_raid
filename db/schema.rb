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

ActiveRecord::Schema.define(version: 20150812155404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "quantity_type"
  end

  create_table "menu_recipes", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "meal_time"
  end

  add_index "menu_recipes", ["menu_id"], name: "index_menu_recipes_on_menu_id", using: :btree
  add_index "menu_recipes", ["recipe_id"], name: "index_menu_recipes_on_recipe_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "menus", ["user_id"], name: "index_menus_on_user_id", using: :btree

  create_table "pantries", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pantries", ["user_id"], name: "index_pantries_on_user_id", using: :btree

  create_table "pantry_ingredients", force: :cascade do |t|
    t.integer  "pantry_id"
    t.integer  "ingredient_id"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "pantry_ingredients", ["ingredient_id"], name: "index_pantry_ingredients_on_ingredient_id", using: :btree
  add_index "pantry_ingredients", ["pantry_id"], name: "index_pantry_ingredients_on_pantry_id", using: :btree

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "prep_method"
  end

  add_index "recipe_ingredients", ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id", using: :btree
  add_index "recipe_ingredients", ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id", using: :btree

  create_table "recipe_steps", force: :cascade do |t|
    t.integer  "step_number"
    t.string   "body"
    t.integer  "recipe_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "recipe_steps", ["recipe_id"], name: "index_recipe_steps_on_recipe_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uid"
    t.string   "image_url"
    t.string   "token"
  end

  add_foreign_key "menu_recipes", "menus"
  add_foreign_key "menu_recipes", "recipes"
  add_foreign_key "menus", "users"
  add_foreign_key "pantries", "users"
  add_foreign_key "pantry_ingredients", "ingredients"
  add_foreign_key "pantry_ingredients", "pantries"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipe_steps", "recipes"
  add_foreign_key "recipes", "users"
end
