# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2) do

  create_table "geo_continents", id: :string, limit: 2, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.json "name", null: false
    t.integer "area", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "geo_coordinates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "coordinatesable_type", null: false
    t.string "coordinatesable_id", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coordinatesable_type", "coordinatesable_id"], name: "ploymorphic_index"
  end

  create_table "geo_countries", id: :string, limit: 2, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "continent_id", limit: 2, null: false
    t.string "capital_id", limit: 8
    t.json "name", null: false
    t.integer "area", null: false
    t.integer "dial", null: false
    t.json "nationality"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["continent_id"], name: "fk_rails_f5719beb49"
  end

  create_table "geo_country_division_level1s", primary_key: ["id", "country_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "id", limit: 8, null: false
    t.string "continent_id", limit: 2, null: false
    t.string "country_id", limit: 2, null: false
    t.bigint "capital_id"
    t.json "name", null: false
    t.integer "area"
    t.integer "dial"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["continent_id"], name: "fk_rails_6cce349da1"
    t.index ["country_id"], name: "fk_rails_913c227dd9"
  end

  create_table "geo_country_division_levels", primary_key: ["country_id", "level"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "continent_id", limit: 2, null: false
    t.string "country_id", limit: 2, null: false
    t.integer "level", null: false
    t.json "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["continent_id"], name: "fk_rails_32895b6f16"
  end

  create_table "medical_disease_cases", primary_key: ["id", "disease_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "id", null: false
    t.string "continent_id", limit: 2
    t.string "country_id", limit: 2
    t.string "level1_id", limit: 8
    t.string "disease_id", null: false
    t.integer "type", null: false
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["continent_id"], name: "fk_rails_4b8fa7a16d"
    t.index ["country_id"], name: "fk_rails_c5936c8790"
    t.index ["disease_id"], name: "fk_rails_4f9ee80319"
    t.index ["level1_id"], name: "fk_rails_47d3fd2e0b"
  end

  create_table "medical_diseases", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.json "name", null: false
    t.json "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "geo_countries", "geo_continents", column: "continent_id"
  add_foreign_key "geo_country_division_level1s", "geo_continents", column: "continent_id"
  add_foreign_key "geo_country_division_level1s", "geo_countries", column: "country_id"
  add_foreign_key "geo_country_division_levels", "geo_continents", column: "continent_id"
  add_foreign_key "geo_country_division_levels", "geo_countries", column: "country_id"
  add_foreign_key "medical_disease_cases", "geo_continents", column: "continent_id"
  add_foreign_key "medical_disease_cases", "geo_countries", column: "country_id"
  add_foreign_key "medical_disease_cases", "geo_country_division_level1s", column: "level1_id"
  add_foreign_key "medical_disease_cases", "medical_diseases", column: "disease_id"
end
