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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140401123601) do

  create_table "kpi_semanales", :force => true do |t|
    t.integer  "anyo"
    t.integer  "semana"
    t.string   "modelo"
    t.string   "scope"
    t.integer  "dato"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kpi_semanales", ["anyo", "semana"], :name => "index_kpi_semanales_on_anyo_and_semana"
  add_index "kpi_semanales", ["modelo", "scope", "anyo", "semana"], :name => "index_kpi_semanales_on_modelo_and_scope_and_anyo_and_semana", :unique => true

end
