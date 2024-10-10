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

ActiveRecord::Schema[7.1].define(version: 2024_10_10_173700) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "houses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.bigint "scenario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scenario_id"], name: "index_players_on_scenario_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "text"
    t.index ["player_id"], name: "index_requirements_on_player_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.string "room_type"
    t.string "side"
    t.string "floor"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_rooms_on_house_id"
  end

  create_table "scenarios", force: :cascade do |t|
    t.integer "player_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "starting_layout_id"
    t.integer "goal_layout_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "type"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id", null: false
    t.index ["room_id"], name: "index_tokens_on_room_id"
  end

  add_foreign_key "players", "scenarios"
  add_foreign_key "requirements", "players"
  add_foreign_key "rooms", "houses"
  add_foreign_key "tokens", "rooms"
end
