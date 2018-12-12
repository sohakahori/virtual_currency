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

ActiveRecord::Schema.define(version: 20181212033636) do

  create_table "coins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "name_kana"
    t.integer "market_rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_rank"], name: "index_coins_on_market_rank", unique: true
    t.index ["name"], name: "index_coins_on_name", unique: true
  end

end
