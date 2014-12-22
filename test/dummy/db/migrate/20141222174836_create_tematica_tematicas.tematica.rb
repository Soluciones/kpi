# coding: UTF-8
# This migration comes from tematica (originally 20140213085144)

class CreateTematicaTematicas < ActiveRecord::Migration
  def self.up
    create_table :tematica_tematicas do |t|
      t.string :nombre
      t.string :seccion_publi

      t.timestamps
    end
  end

  def self.down
    drop_table :tematica_tematicas
  end
end
