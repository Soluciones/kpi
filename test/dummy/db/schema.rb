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

ActiveRecord::Schema.define(:version => 20140407081316) do

  create_table "contenidos", :force => true do |t|
    t.string   "titulo"
    t.integer  "usuario_id"
    t.integer  "subtipo_id"
    t.integer  "tema"
    t.boolean  "publicado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "tematica_tematizaciones", :force => true do |t|
    t.integer  "tematizable_id",                    :null => false
    t.string   "tematizable_type",                  :null => false
    t.string   "tematizable_grupo", :default => "", :null => false
    t.integer  "tematica_id",                       :null => false
    t.boolean  "explicita"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tematica_tematizaciones", ["tematica_id", "tematizable_type", "tematizable_grupo", "tematizable_id"], :name => "ix_tematizaciones_by_tematica_and_type_grupo", :unique => true
  add_index "tematica_tematizaciones", ["tematizable_type", "tematizable_id"], :name => "ix_tematizaciones_by_tematizable"

  create_table "usuarios", :force => true do |t|
    t.string   "nick"
    t.string   "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
