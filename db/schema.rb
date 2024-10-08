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

ActiveRecord::Schema.define(version: 2016_09_29_212810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cameras", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "rover_id"
    t.string "full_name"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "img_src", null: false
    t.integer "sol", null: false
    t.string "old_camera"
    t.date "earth_date"
    t.integer "rover_id"
    t.integer "camera_id"
    t.index ["camera_id"], name: "index_photos_on_camera_id"
    t.index ["earth_date"], name: "index_photos_on_earth_date"
    t.index ["img_src"], name: "index_photos_on_img_src"
    t.index ["rover_id"], name: "index_photos_on_rover_id"
    t.index ["sol", "camera_id", "img_src", "rover_id"], name: "index_photos_on_sol_and_camera_id_and_img_src_and_rover_id", unique: true
    t.index ["sol"], name: "index_photos_on_sol"
  end

  create_table "rovers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.date "landing_date"
    t.date "launch_date"
    t.string "status"
  end

end
