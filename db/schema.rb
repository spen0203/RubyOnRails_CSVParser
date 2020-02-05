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

ActiveRecord::Schema.define(version: 2020_01_25_163422) do

  create_table "records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "REF_DATE"
    t.string "GEO"
    t.string "DGUID"
    t.string "Sex"
    t.string "Age_group"
    t.string "Student_response"
    t.string "UOM"
    t.string "UOM_ID"
    t.string "SCALAR_FACTOR"
    t.string "SCALAR_ID"
    t.string "VECTOR"
    t.string "COORDINATE"
    t.string "VALUE"
    t.string "STATUS"
    t.string "SYMBOL"
    t.string "TERMINATED"
    t.string "DECIMALS"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
